return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "odin",
      root = { "ols.json" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "odin" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ols = {},
      },
    },
  },
}
