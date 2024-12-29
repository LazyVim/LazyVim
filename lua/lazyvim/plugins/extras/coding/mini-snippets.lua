--[[

This extra for mini.snippets activates the following:
1. During completion with either cmp or blink, expand lsp snippets
2. To use other snippets: Press <c-j> in insert mode

Note that there is no completion source. 
Other snippets(custom or from friendly-snippets) are handled by pressing <c-j> in insert mode.

In default LazyVim, neither cmp nor blink define the default mappings used by mini.snippets
For now, pressing tab and shift-tab inside a snippet just inserts a tab

-- TODO: Find a way to incorporate user defined mappings including super-tab
-- TODO: Find a way to more easily support lang_patterns for snippets.gen_loader.from_lang
--]]
local function expand(args)
  ---@diagnostic disable-next-line: undefined-global
  local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
  insert({ body = args.body }) -- insert at cursor
end

local snippet_select_for_cmp = function(snippets, insert, opts)
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.close()
  end

  MiniSnippets.default_select(snippets, insert, opts)
end
local snippet_select_for_blink = function(snippets, insert, opts)
  -- Blink's cancel uses vim.schedule!
  require("blink.cmp").cancel()

  -- Schedule, otherwise blink's virtual text is not removed on vim.ui.select
  vim.schedule(function()
    MiniSnippets.default_select(snippets, insert, opts)
  end)
end
local snippet_select_without_completion_engine = function(snippets, insert, opts)
  MiniSnippets.default_select(snippets, insert, opts)
end
local snippet_select = snippet_select_without_completion_engine

return {
  -- disable builtin snippet support
  { "garymjr/nvim-snippets", optional = true, enabled = false },
  -- disable luasnip:
  { "L3MON4D3/LuaSnip", optional = true, enabled = false },

  -- add mini.snippets
  desc = "Manage and expand snippets (alternative for luasnip), currently in beta",
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
          snippets.gen_loader.from_lang(),
        },
        expand = {
          select = function(...)
            snippet_select(...) -- close completion windows on snippet select
          end,
        },
      }
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
          return false -- mini.snippets operates independently
        end,
        jump = function() end, -- mini.snippets operates independently
      }
    end,
  },
}
