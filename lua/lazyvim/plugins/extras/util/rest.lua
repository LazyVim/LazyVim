local k = require("lazyvim.keymaps").get_keymaps().extras.util.rest.kulala

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
      { k.prefix, "", desc = "+Rest" },
      { k.send_request, "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { k.toggle_view, "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { k.jump_to_previous_request, "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { k.jump_to_next_request, "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
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
