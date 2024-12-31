--[[
TODO: Prevent the user from overriding mini.snippits mappings?

An extra for mini.snippets.
Includes a completion source for `nvim-cmp`
There is an open issue for `blink.cmp`: https://github.com/Saghen/blink.cmp/issues/741

For now, `blink.cmp` is out of scope in this extra. 
Use extra "mini_snippets_standalone" to expand the snippets from the lsp with blink.

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

local function jump(direction)
  local is_active = MiniSnippets.session.get(false) ~= nil
  if is_active then
    MiniSnippets.session.jump(direction)
    return true
  end
end

return {
  -- disable builtin snippet support
  { "garymjr/nvim-snippets", optional = true, enabled = false },
  -- disable luasnip:
  { "L3MON4D3/LuaSnip", optional = true, enabled = false },

  -- add mini.snippets
  desc = "Beta testing mini.snippets, a plugin to manage and expand snippets (alternative for luasnip)",
  {
    "echasnovski/mini.snippets",
    lazy = true,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
      },
    },
    opts = function()
      local snippets = require("mini.snippets")
      return {
        snippets = {
          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          snippets.gen_loader.from_lang(),
        },
        mappings = { -- handled by completion engine.
          expand = "",
          jump_next = "",
          jump_prev = "",
        },
      }
    end,
  },

  -- add snippet_forward action
  {
    "echasnovski/mini.snippets",
    opts = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_forward = function()
        return jump("next")
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.cmp.actions.snippet_stop = function()
        -- Only needed for luasnip unlink
      end
    end,
  },

  -- nvim-cmp integration: Use mini.snippets to expand snippets from lsp
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "abeldekat/cmp-mini-snippets" },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          expand(args)
        end,
      }
      table.insert(opts.sources, { name = "mini_snippets" })
    end,
    -- stylua: ignore
    keys = {
      -- <tab> is configured as cmp.mapping in nvim-cmp extra:
      { "<tab>", function() jump("next") end, mode = "i" },
      { "<s-tab>", function() jump("prev") end, mode = "i" },
    },
  },
}
