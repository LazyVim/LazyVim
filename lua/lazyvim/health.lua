local M = {}

local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error
local info = vim.health.info or vim.health.report_info

function M.check()
  start("LazyVim")

  if vim.fn.has("nvim-0.11.2") == 1 then
    ok("Using Neovim >= 0.11.2")
  else
    error("Neovim >= 0.11.2 is required")
  end

  for _, cmd in ipairs({ "git", "rg", { "fd", "fdfind" }, "lazygit", "fzf", "curl" }) do
    local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
    local commands = type(cmd) == "string" and { cmd } or cmd
    ---@cast commands string[]
    local found = false

    for _, c in ipairs(commands) do
      if vim.fn.executable(c) == 1 then
        name = c
        found = true
      end
    end

    if found then
      ok(("`%s` is installed"):format(name))
    else
      warn(("`%s` is not installed"):format(name))
    end
  end

  start("LazyVim nvim-treesitter")
  local tsok, health = LazyVim.treesitter.check()
  local keys = vim.tbl_keys(health) ---@type string[]
  table.sort(keys)
  for _, k in pairs(keys) do
    (health[k] and ok or error)(("`%s` is %s"):format(k, health[k] and "installed" or "not installed"))
  end
  if not tsok then
    info(
      "See the requirements at [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements)"
    )
    info("Run `:checkhealth nvim-treesitter` for more information.")
    if vim.fn.has("win32") == 1 and not health["C compiler"] then
      info("Install a C compiler with `winget install --id=BrechtSanders.WinLibs.POSIX.UCRT -e`")
    end
  end
end

return M
