return {

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({ style = "moon" })
      tokyonight.load()
    end,
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
}
