return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      -- [U]ndo [T]ree
      { "<leader>uT", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree Toggle" },
    },
    init = function()
      -- Persist undo, refer https://github.com/mbbill/undotree#usage
      local undodir = vim.fn.expand("~/.undo-nvim")

      if vim.fn.has("persistent_undo") == 1 then
        if vim.fn.isdirectory(undodir) == 0 then
          os.execute("mkdir -p " .. undodir)
        end

        vim.opt.undodir = undodir
        vim.opt.undofile = true
      end

      -- set layout style to 2, let g:undotree_WindowLayout = 2
      vim.g.undotree_WindowLayout = 2
    end,
  },
}
