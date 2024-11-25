return {
  -- disable builtin snippet support
  { "garymjr/nvim-snippets", enabled = false },

  -- add luasnip
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not LazyVim.is_win())
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },

  -- add snippet_forward action
  {
    "L3MON4D3/LuaSnip",
    opts = function()
      LazyVim.cmp.actions.snippet_forward = function()
        if require("luasnip").jumpable(1) then
          require("luasnip").jump(1)
          return true
        end
      end
    end,
  },

  -- nvim-cmp integration
  {
    "nvim-cmp",
    optional = true,
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      table.insert(opts.sources, { name = "luasnip" })
    end,
    -- stylua: ignore
    keys = {
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  -- blink.cmp integration
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      accept = {
        expand_snippet = function(...)
          return require("luasnip").lsp_expand(...)
        end,
      },
    },
  },
}
