vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})
return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    -- stylua: ignore
    keys = {
      { "<leader>R", "", desc = "+Rest" },
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<leader>Ra", "<cmd>lua require('kulala').run_all()<cr>", desc = "Send all request" },
      { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
      { "[[", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "]]", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
      { "<leader>Rr", "<cmd>lua require('kulala').replay()<cr>", ft = "http", desc = "Replay Last Request" },
      { "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", ft = "http", desc = "Copy as cURL command" },
      { "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", ft = "http", desc = "Parse cURL command from clipboard", },
      { "<leader>Re", "<cmd>lua require('kulala').set_selected_env()<cr>", ft = "http", desc = "Select Env" },
      { "<leader>Rf", "<cmd>lua require('kulala').search()<cr>", ft = "http", desc = "Find HTTP Files" },
    },
    opts = {
      winbar = true,
      default_winbar_panes = { "body", "headers", "headers_body", "script_output" },
      disable_script_print_output = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "http", "graphql" },
    },
  },
}
