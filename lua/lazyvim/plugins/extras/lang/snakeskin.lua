return {
  recommended = {
    ft = "ss",
    root = "package.json",
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "snakeskin-cli" } },
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
