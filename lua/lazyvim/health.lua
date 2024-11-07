local M = {}

local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error

function M.check()
  start("LazyVim")

  if vim.fn.has("nvim-0.9.0") == 1 then
    ok("Using Neovim >= 0.9.0")
    if vim.fn.has("nvim-0.10.0") == 0 then
      warn("Use Neovim >= 0.10.0 for the best experience")
    end
  else
    error("Neovim >= 0.9.0 is required")
  end
end

return M
