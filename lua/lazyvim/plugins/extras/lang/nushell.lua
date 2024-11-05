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
    opts = { ensure_installed = { "nu" } },
  },
}
