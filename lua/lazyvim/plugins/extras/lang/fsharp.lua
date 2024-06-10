-- requires dotnet sdk  to be installed
return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "fs", "fsx", "fsi" },
      root = { "*.fsproj" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.fsharp = {
        install_info = {
          url = "https://github.com/ionide/tree-sitter-fsharp",
          branch = "main",
          files = { "src/scanner.c", "src/parser.c" },
        },
        filetype = "fsharp",
      }
    end,
    opts = { ensure_installed = { "fsharp" } },
  },
  {
    "ionide/Ionide-vim",
    event = "VeryLazy",
  },
  {
    "mason.nvim",
    opts = { ensure_installed = {
      "fsautocomplete",
      "fantomas",
    } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.fantomas,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        fs = { "fantomas" },
        fsi = { "fantomas" },
        fsx = { "fantomas" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        fsautocomplete = {},
      },
    },
  },
}
