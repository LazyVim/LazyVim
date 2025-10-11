return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "quarto",
      root = {
        "_quarto.yml",
      },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    -- needs treesitter, but no additional grammar,
    -- because quarto uses the markdown grammar
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
    },
    opts = {},
  },
}
