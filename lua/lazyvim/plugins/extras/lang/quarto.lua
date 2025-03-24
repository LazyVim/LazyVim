return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  recommended = function()
    return LazyVim.extras.wants({
      ft = "quarto",
    })
  end,
}
