local M = {}

function M.check()
  vim.health.report_start("LazyVim")

  if vim.fn.has("nvim-0.8.0") == 1 then
    vim.health.report_ok("Using Neovim >= 0.8.0")
  else
    vim.health.report_error("Neovim >= 0.8.0 is required")
  end

  for _, cmd in ipairs({ "git", "rg", "fd", "lazygit" }) do
    if vim.fn.executable(cmd) == 1 then
      vim.health.report_ok(("`%s` is installed"):format(cmd))
    else
      vim.health.report_warn(("`%s` is not installed"):format(cmd))
    end
  end
end

return M
