return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  enabled = function()
    if vim.fn.executable("yazi") == 1 then
      return true
    end
    return false
  end,
  lazy = true,
  keys = {
    {
      "<C-a>",
      function()
        require("yazi").yazi()
      end,
      desc = "Open the file manager",
    },
    {
      "<leader>a",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open yazi in CWD",
    },
  },
  opts = {
    open_for_directories = true,
    floating_window_scaling_factor = 1,
  },
}
