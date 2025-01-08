if lazyvim_docs then
  -- set to `false` to prevent "non-lsp snippets"" from appearing inside completion windows
  -- motivation: less clutter in completion windows and a more direct usage of snippits
  vim.g.lazyvim_mini_snippets_in_cmp = true

  -- NOTE: Please also read:
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-snippets.md#expand
  -- :h MiniSnippets-session
end

local snippets_in_completion = vim.g.lazyvim_mini_snippets_in_cmp == nil or vim.g.lazyvim_mini_snippets_in_cmp

--[[
Example override for your own config:
return {
  {
    "echasnovski/mini.snippets",
    opts = function(_, opts)
      -- By default, for opts.snippets, the extra for mini.snippets only adds gen_loader.from_lang()
      -- This provides a sensible quickstart, integrating with friendly-snippets
      -- and your own language-specific snippets
      --
      -- In order to change opts.snippets, replace the entire table inside your own opts

      local snippets, config_path = require("mini.snippets"), vim.fn.stdpath("config")

      opts.snippets = { -- override opts.snippets provided by extra...
        -- Load custom file with global snippets first (order matters)
        snippets.gen_loader.from_file(config_path .. "/snippets/global.json"),

        -- Load snippets based on current language by reading files from
        -- "snippets/" subdirectories from 'runtimepath' directories.
        snippets.gen_loader.from_lang(), -- this is the default in the extra...
      }
    end,
  },
}
--]]

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
local on_mini_expand_select = nil

return {
  -- disable builtin snippet support:
  { "garymjr/nvim-snippets", optional = true, enabled = false },
  -- disable luasnip:
  { "L3MON4D3/LuaSnip", optional = true, enabled = false },

  -- add mini.snippets
  desc = "mini.snippets(beta), a plugin to manage and expand snippets (alternative for luasnip)",
  {
    "echasnovski/mini.snippets",
    event = "InsertEnter", -- don't depend on other plugins to load...
    dependencies = "rafamadriz/friendly-snippets",
    opts = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_stop = function() end -- by design, <esc> should not stop the session!
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_forward = function()
        return jump("next")
      end

      local mini_snippets = require("mini.snippets")
      return {
        snippets = { mini_snippets.gen_loader.from_lang() },
        expand = {
          -- If applicable, close completion window on snippet select - vim.ui.select
          -- Needed to remove virtual text for fzf-lua and telescope, but not for mini.pick...
          select = function(snippets, insert)
            if on_mini_expand_select then
              on_mini_expand_select(snippets, insert)
            else
              MiniSnippets.default_select(snippets, insert)
            end
          end,
        },
      }
    end,
  },

  -- nvim-cmp integration
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = snippets_in_completion and { "abeldekat/cmp-mini-snippets" } or nil,
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          expand_from_lsp(args.body)
        end,
      }
      if snippets_in_completion then -- return early when snippets_in_completion
        table.insert(opts.sources, { name = "mini_snippets" })
        return
      end

      -- Standalone --
      local function close_cmp()
        local cmp = require("cmp")
        -- stylua: ignore
        if cmp.visible() then cmp.close() end
      end
      on_mini_expand_select = function(snippets, insert)
        close_cmp()
        MiniSnippets.default_select(snippets, insert)
      end
    end,
    -- stylua: ignore
    -- counterpart to <tab> defined in cmp.mappings
    keys = snippets_in_completion and { { "<s-tab>", function() jump("prev") end, mode = "i" } } or nil,
  },

  -- blink.cmp integration
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      if snippets_in_completion then -- return early when snippets_in_completion
        opts.snippets = { preset = "mini_snippets" }
        return
      end

      -- Standalone --
      local function close_cmp()
        require("blink.cmp").cancel()
      end
      on_mini_expand_select = function(snippets, insert)
        -- Schedule, otherwise blink's virtual text is not removed on vim.ui.select
        close_cmp()
        vim.schedule(function()
          MiniSnippets.default_select(snippets, insert)
        end)
      end
      --
      -- Blink performs a require on blink.cmp.sources.snippets.default
      -- By removing the source, the default engine will not be used
      opts.sources.default = vim.tbl_filter(function(source)
        return source ~= "snippets"
      end, opts.sources.default)
      opts.snippets = { -- need to repeat blink's preset here
        expand = expand_from_lsp,
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
