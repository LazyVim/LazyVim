if vim.fn.has("nvim-0.11.2") == 0 then
  vim.api.nvim_echo({
    { "LazyVim requires Neovim >= 0.11.2\n", "ErrorMsg" },
    { "For more info, see: https://github.com/LazyVim/LazyVim/issues/6421\n", "Comment" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

require("lazyvim.config").init()

return {
  { "folke/lazy.nvim", version = "*" },
  { "LazyVim/LazyVim", priority = 10000, lazy = false, opts = {}, cond = true, version = "*" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      if LazyVim.has("noice.nvim") then
        vim.notify = notify
      end
    end,
  },
}
