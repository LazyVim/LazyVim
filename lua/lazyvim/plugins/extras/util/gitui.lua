return {

  -- Ensure GitUI tool is installed
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "gitui" } },
    keys = {
      {
        "<leader>gG",
        function()
          LazyVim.terminal.open({ "gitui" }, { esc_esc = false, ctrl_hjkl = false })
        end,
        desc = "GitUi (cwd)",
      },
      {
        "<leader>gg",
        function()
          LazyVim.terminal.open({ "gitui" }, { cwd = LazyVim.root.get(), esc_esc = false, ctrl_hjkl = false })
        end,
        desc = "GitUi (Root Dir)",
      },
    },
    init = function()
      -- delete lazygit keymap for file history
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimKeymaps",
        once = true,
        callback = function()
          pcall(vim.keymap.del, "n", "<leader>gf")
          pcall(vim.keymap.del, "n", "<leader>gl")
        end,
      })
    end,
  },
}
