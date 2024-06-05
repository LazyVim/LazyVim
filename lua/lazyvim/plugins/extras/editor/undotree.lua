return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree Toggle" },
    },
    init = function()
      -- set layout style to 2, let g:undotree_WindowLayout = 2
      vim.g.undotree_WindowLayout = 2
    end,
  },
}
