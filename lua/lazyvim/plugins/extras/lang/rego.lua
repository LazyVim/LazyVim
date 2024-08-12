return {
  recommended = {
    ft = "rego",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        regols = {},
        regal = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "rego" },
    },
  },
}
