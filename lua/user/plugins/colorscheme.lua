return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({ style = "moon" })
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
}
