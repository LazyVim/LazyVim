if vim.fn.has("nvim-0.9.0") == 0 then
  vim.api.nvim_echo({
    { "LazyVim requires Neovim >= 0.9.0\n", "ErrorMsg" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

require("lazyvim.config").init()

local Git = require("lazy.manage.git")
local Util = require("lazy.core.util")

local function find_actual_origin_spec()
  local current_dir = vim.fn.fnamemodify(Util.get_source(), ":h")
  return {
    url = Git.get_origin(Util.find_git_root(current_dir)),
    priority = 10000,
    lazy = false,
    opts = {},
    cond = true,
    version = "*",
  }
end

return {
  { "folke/lazy.nvim", version = "*" },
  find_actual_origin_spec(),
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
