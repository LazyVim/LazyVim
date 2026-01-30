return {
  "Masalale/buffer-jump.nvim",
  opts = {
    width = 55,
    max_height = 12,
    border = "rounded",
  },
  keys = {
    {
      "<leader>bj",
      function()
        require("buffer-jump").jump_to_buffer()
      end,
      desc = "Jump to Buffer",
    },
  },
}
