if lazyvim_docs then
  -- Set to `false` to prevent "non-lsp snippets"" from appearing inside completion windows
  -- Motivation: Less clutter in completion windows and a more direct usage of snippits
  vim.g.lazyvim_mini_snippets_in_completion = true

  -- NOTE: Please also read:
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-snippets.md#expand
  -- :h MiniSnippets-session

  -- NOTE: To add your own snippets, you will need an extension manifest
  -- in a runtime directory (e.g. ~/.config/nvim/package.json)
  -- See https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
  -- for friendly-snippets' manifest
  -- See https://code.visualstudio.com/api/references/extension-manifest
  -- and https://code.visualstudio.com/api/references/contribution-points#contributes.snippets
  -- for the original spec
  --
  -- To add other snippets to a filetype, add them to opts.filetype_additions
  -- To override a lang's filetypes, add an entry to opts.lang_filetypes
  -- For example:
  --[[
  return {
    {
      "echasnovski/mini.snippets",
      opts = {
        filetype_additions = { plaintext = { "license", "loremipsum" } },
        -- use "plaintext" snippets when context.lang is "text"
        lang_filetypes = { text = { "plaintext" } },
      },
    },
  }
  --]]

  -- Example override for your own config:
  --[[
  return {
    {
      "echasnovski/mini.snippets",
      opts = function(_, opts)
        -- By default, for opts.snippets, the extra for mini.snippets only adds from_package_json()
        -- This provides a sensible quickstart, integrating with friendly-snippets
        --
        -- In order to change opts.snippets, replace the entire table inside your own opts

        local snippets, config_path = require("mini.snippets"), vim.fn.stdpath("config")

        opts.snippets = { -- override opts.snippets provided by extra...
          -- Load custom file with global snippets first (order matters)
          snippets.gen_loader.from_file(config_path .. "/snippets/global.json"),

          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          snippets.gen_loader.from_lang(),
        }
      end,
    },
  }
--]]
end

local include_in_completion = vim.g.lazyvim_mini_snippets_in_completion == nil
  or vim.g.lazyvim_mini_snippets_in_completion

local function expand_from_lsp(snippet)
  local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
  insert({ body = snippet })
end

local function jump(direction)
  local is_active = MiniSnippets.session.get(false) ~= nil
  if is_active then
    MiniSnippets.session.jump(direction)
    return true
  end
end

---@type fun(snippets, insert) | nil
local expand_select_override = nil

return {
  -- disable builtin snippet support:
  { "garymjr/nvim-snippets", optional = true, enabled = false },
  -- disable luasnip:
  { "L3MON4D3/LuaSnip", optional = true, enabled = false },

  -- add mini.snippets
  desc = "Manage and expand snippets (alternative to Luasnip)",
  {
    "echasnovski/mini.snippets",
    event = "InsertEnter", -- don't depend on other plugins to load...
    dependencies = "rafamadriz/friendly-snippets",
    config = function(_, opts)
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_stop = function() end -- by design, <esc> should not stop the session!
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_forward = function()
        return jump("next")
      end

      local mini_snippets = require("mini.snippets")

      local function from_package_json()
        local filetype_additions, lang_filetypes = opts.filetype_additions or {}, opts.lang_filetypes or {}

        local cache = { filetype_snippets = {}, lang_snippets = {}, paths = nil }

        local function get_paths(filetype)
          if cache.paths ~= nil then
            cache.paths[filetype] = cache.paths[filetype] or {}
            return cache.paths[filetype]
          end

          cache.paths = {}

          local function insert_path(lang, root, path)
            cache.paths[lang] = cache.paths[lang] or {}
            table.insert(cache.paths[lang], vim.fs.joinpath(root, path))
          end

          local manifests = vim.api.nvim_get_runtime_file("package.json", true)
          for _, manifest in ipairs(manifests) do
            local function warn_of_manifest(msg)
              LazyVim.warn({ "Could not parse", manifest, "", msg }, { title = "mini-snippets extra" })
            end

            if vim.fn.filereadable(manifest) ~= 1 then
              warn_of_manifest("File is not readable")
              goto continue
            end

            local file, err = io.open(manifest)

            if file == nil then
              warn_of_manifest(err)
              goto continue
            end

            local contents = file:read("*a")

            file:close()

            local ok, json = pcall(vim.json.decode, contents)

            if not ok then
              warn_of_manifest(json)
              goto continue
            end

            if type(json) ~= "table" then
              warn_of_manifest("Contents should be a table")
              goto continue
            end

            local snippets = vim.tbl_get(json, "contributes", "snippets")

            if snippets == nil then
              goto continue
            end

            if type(snippets) ~= "table" then
              warn_of_manifest("`snippets` should be a table")
              goto continue
            end

            local i = 0
            for _ in pairs(snippets) do
              i = i + 1

              local snippet = snippets[i]

              if snippet == nil or type(snippet) ~= "table" then
                warn_of_manifest("`snippets` should be a list of tables")
                goto continue
              end

              if type(snippet.path) ~= "string" then
                warn_of_manifest("`path` of snippet #" .. i .. " should be a string")
                goto continue
              end

              local language = snippet.language
              if type(language) == "table" then
                local j = 0
                for _ in pairs(language) do
                  j = j + 1

                  if type(language[j]) ~= "string" then
                    warn_of_manifest(
                      "`language` of snippet #"
                        .. i
                        .. " should be a string, a list of strings, or nil for global snippets"
                    )
                    goto continue
                  end
                end
              elseif not (type(language) == "string" or language == nil) then
                warn_of_manifest(
                  "`language` of snippet #" .. i .. " should be a string, a list of strings, or nil for global snippets"
                )
                goto continue
              end
            end

            local root = vim.fs.dirname(manifest)

            for _, snippet in ipairs(snippets) do
              local language = snippet.language
              local path = snippet.path

              if type(language) == "table" then
                for _, ft in ipairs(language) do
                  insert_path(ft, root, path)
                end
              elseif type(language) == "string" then
                insert_path(language, root, path)
              else
                insert_path("global", root, path)
              end
            end

            ::continue::
          end

          cache.paths[filetype] = cache.paths[filetype] or {}
          return cache.paths[filetype]
        end

        local function get_filetype_snippets(filetype)
          if type(filetype) == "string" then
            if cache.filetype_snippets[filetype] ~= nil then
              return cache.filetype_snippets[filetype]
            end

            local paths = {}
            for _, ft in ipairs(filetype_additions[filetype] or {}) do
              for _, path in ipairs(get_paths(ft)) do
                table.insert(paths, path)
              end
            end
            for _, path in ipairs(get_paths(filetype)) do
              table.insert(paths, path)
            end

            cache.filetype_snippets[filetype] = vim.tbl_map(mini_snippets.read_file, paths)
            return cache.filetype_snippets[filetype]
          end

          return vim.tbl_map(get_filetype_snippets, filetype)
        end

        local function get_lang_snippets(lang)
          cache.lang_snippets[lang] = cache.lang_snippets[lang]
            or get_filetype_snippets(lang_filetypes[lang] or { vim.treesitter.language.get_filetypes(lang), "global" })
          return cache.lang_snippets[lang]
        end

        return function(context)
          local lang = (context or {}).lang

          if type(lang) ~= "string" then
            return get_lang_snippets("global")
          end

          return get_lang_snippets(lang)
        end
      end

      opts = vim.tbl_deep_extend("force", {
        snippets = { from_package_json() },

        -- Following the behavior of vim.snippets,
        -- the intended usage of <esc> is to be able to temporarily exit into normal mode for quick edits.
        --
        -- If you'd rather stop the snippet on <esc>, activate the line below in your own config:
        -- mappings = { stop = "<esc>" }, -- <c-c> by default, see :h MiniSnippets-session

        expand = {
          select = function(snippets, insert)
            -- Close completion window on snippet select - vim.ui.select
            -- Needed to remove virtual text for fzf-lua and telescope, but not for mini.pick...
            local select = expand_select_override or MiniSnippets.default_select
            select(snippets, insert)
          end,
        },
      }, opts)

      mini_snippets.setup(opts)
    end,
  },

  -- nvim-cmp integration
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = include_in_completion and { "abeldekat/cmp-mini-snippets" } or nil,
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_config = require("cmp.config")

      opts.snippet = {
        expand = function(args)
          expand_from_lsp(args.body)
          cmp.resubscribe({ "TextChangedI", "TextChangedP" })
          cmp_config.set_onetime({ sources = {} })
        end,
      }

      if include_in_completion then
        table.insert(opts.sources, { name = "mini_snippets" })
      else
        expand_select_override = function(snippets, insert)
          -- stylua: ignore
          if cmp.visible() then cmp.close() end
          MiniSnippets.default_select(snippets, insert)
        end
      end
    end,
    -- stylua: ignore
    -- counterpart to <tab> defined in cmp.mappings
    keys = include_in_completion and { { "<s-tab>", function() jump("prev") end, mode = "i" } } or nil,
  },

  -- blink.cmp integration
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      -- Return early
      if include_in_completion then
        opts.snippets = { preset = "mini_snippets" }
        return
      end

      -- Standalone --
      local blink = require("blink.cmp")
      expand_select_override = function(snippets, insert)
        -- Schedule, otherwise blink's virtual text is not removed on vim.ui.select
        blink.cancel()
        vim.schedule(function()
          MiniSnippets.default_select(snippets, insert)
        end)
      end
      --
      -- Blink performs a require on blink.cmp.sources.snippets.default
      -- By removing the source, that default engine will not be used
      opts.sources.default = vim.tbl_filter(function(source)
        return source ~= "snippets"
      end, opts.sources.default)
      opts.snippets = { -- need to repeat blink's preset here
        expand = function(snippet)
          expand_from_lsp(snippet)
          blink.resubscribe()
        end,
        active = function()
          return MiniSnippets.session.get(false) ~= nil
        end,
        jump = function(direction)
          jump(direction == -1 and "prev" or "next")
        end,
      }
    end,
  },
}
