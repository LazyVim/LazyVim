return {
  recommended = {
    ft = "ss",
    root = "package.json",
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "snakeskin_ls" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        snakeskin_ls = {},
      },
    },
  },
}
