local k = require("lazyvim.keymaps").get_keymaps().extras.coding.luasnip

return {
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
      {
        "nvim-cmp",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
        },
        opts = function(_, opts)
          opts.snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          }
          table.insert(opts.sources, { name = "luasnip" })
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "nvim-cmp",
    -- stylua: ignore
    keys = {
      {
        k.jump_next,
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { k.jump_next, function() require("luasnip").jump(1) end, mode = "s" },
      { k.jump_prev, function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "garymjr/nvim-snippets",
    enabled = false,
  },
}
