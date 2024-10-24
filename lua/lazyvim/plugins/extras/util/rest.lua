vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})
return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>R", "", desc = "+Rest" },
      { "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
      { "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL" },
      { "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl" },
      { "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request" },
      { "<leader>Rg", "<cmd>lua require('kulala').download_graphql_schema()<cr>", desc = "Download GraphQL schema" },
      { "<leader>Rr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<leader>RS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats" },
      { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
      { "<leader>Rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window" },
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "http", "graphql" },
    },
  },
}
