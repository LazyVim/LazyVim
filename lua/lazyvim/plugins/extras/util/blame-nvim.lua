return {
  "FabijanZulj/blame.nvim",
  config = function()
    require("blame").setup()
  end,
  keys = {
    { mode = "n", "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Git Blame file" },
  },
}
