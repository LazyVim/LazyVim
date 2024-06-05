return {
  recommended = {
    ft = "nu",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nushell = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nushell/tree-sitter-nu" },
    },
    opts = function(_, opts)
      ---@diagnostic disable-next-line: inject-field
      require("nvim-treesitter.parsers").get_parser_configs().nu = {
        install_info = {
          url = "https://github.com/nushell/tree-sitter-nu",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "nu",
      }

      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "nu" })
      end
    end,
  },
}
