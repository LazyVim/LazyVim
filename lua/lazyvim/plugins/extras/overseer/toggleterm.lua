return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    dependencies = "akinsho/toggleterm.nvim",
    opts = {
      strategy = { "toggleterm" },
    },
  },
}
