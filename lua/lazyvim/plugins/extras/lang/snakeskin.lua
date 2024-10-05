return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "ss" },
      root = { "package.json" },
    })
  end,
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      snakeskin_ls = {},
    },
  },
}
