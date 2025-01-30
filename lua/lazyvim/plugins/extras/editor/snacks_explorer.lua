return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          Snacks.picker.explorer({ cwd = LazyVim.root() })
        end,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<leader>fE",
        function()
          Snacks.picker.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("snacks_explorer_start_directory", { clear = true }),
        desc = "Start Snacks Explorer with directory",
        once = true,
        callback = function()
          local dir = vim.fn.argv(0) --[[@as string]]
          if dir ~= "" and vim.fn.isdirectory(dir) == 1 then
            Snacks.picker.explorer({ cwd = dir })
          end
        end,
      })
    end,
  },
}
