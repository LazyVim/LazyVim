--[[

This extra for mini.snippets activates the following:
1. During completion with either cmp or blink, expand lsp snippets
2. To use other snippets: Press <c-j> in insert mode

Do note that there are no sources yet for `nvim-cmp` or `blink.cmp`. 
This extra will be updated when those sources become available.

For now, non-lsp snippets(custom or from a plugin aka friendly-snippets) 
are handled exclusively by mini.snippets(<c-j> in insert mode).
This approach is also how the author uses the plugin.

In default LazyVim, neither cmp nor blink define the default mappings used by mini.snippets:
- <c-j> to expand
- <c-l> to jump next (dynamically created when in snippet context)
- <c-h> to jump previous (dynamically created when in snippet context)

It's difficult to have jump_next or jump_previous working in all cases when mapped to <tab>/<s-tab>.

For now, the tab key inside a snippet just inserts a tab.
LazyVim will warn the user when jump_next of jump_previous are overriden.

Currently, mini.snippets is in "beta": See https://github.com/echasnovski/mini.nvim/issues/1428

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

local function expand(args)
  ---@diagnostic disable-next-line: undefined-global
  local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
  insert({ body = args.body }) -- insert at cursor
end

local snippet_select_for_cmp = function(snippets, insert)
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.close()
  end

  MiniSnippets.default_select(snippets, insert)
end
local snippet_select_for_blink = function(snippets, insert)
  -- Blink's cancel uses vim.schedule!
  require("blink.cmp").cancel()

  -- Schedule, otherwise blink's virtual text is not removed on vim.ui.select
  vim.schedule(function()
    MiniSnippets.default_select(snippets, insert)
  end)
end
local snippet_select_without_completion_engine = function(snippets, insert)
  MiniSnippets.default_select(snippets, insert)
end
local snippet_select = snippet_select_without_completion_engine

return {
  -- disable builtin snippet support
  { "garymjr/nvim-snippets", optional = true, enabled = false },
  -- disable luasnip:
  { "L3MON4D3/LuaSnip", optional = true, enabled = false },

  -- add mini.snippets
  desc = "Beta testing mini.snippets, a plugin to manage and expand snippets (alternative for luasnip)",
  {
    "echasnovski/mini.snippets",
    event = "InsertEnter",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
      },
    },
    opts = function()
      -- Unset snippet_forward. Handled by mini.snippets:
      LazyVim.cmp.actions.snippet_forward = nil

      ---Dummy snippet_stop, only needed because "esc" is overriden. See keymaps.lua
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_stop = function() end

      local snippets = require("mini.snippets")
      return {
        snippets = {
          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          snippets.gen_loader.from_lang(),
        },
        expand = {
          select = function(...)
            snippet_select(...) -- if needed, close completion windows on snippet select
          end,
        },
      }
    end,
    config = function(_, opts)
      if opts.mappings and (opts.mappings.jump_next or opts.mappings.jump_previous) then
        LazyVim["warn"]({
          "`mini.snippets`:",
          "Don't override jump_next or jump_previous.",
          "This does not work correctly in all cases.",
        }, { title = "LazyVim" })
      end
      require("mini.snippets").setup(opts)
    end,
  },

  -- nvim-cmp integration: Use mini.snippets to expand snippets from lsp
  {
    "hrsh7th/nvim-cmp",
    init = function()
      snippet_select = snippet_select_for_cmp
    end,
    optional = true,
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          expand(args) -- provide snippet expansion for lsp
        end,
      }
    end,
  },

  -- blink.cmp integration: Use mini.snippets to expand snippets from lsp
  {
    "saghen/blink.cmp",
    init = function()
      snippet_select = snippet_select_for_blink
    end,
    optional = true,
    opts = function(_, opts)
      opts.snippets = {
        expand = function(snippet)
          expand({ body = snippet }) -- provide snippet expansion for lsp
        end,
        active = function()
          return false -- mini.snippets operates independently, blink is closed
        end,
        jump = function() end, -- mini.snippets operates independently, blink is closed
      }
    end,
  },
}
