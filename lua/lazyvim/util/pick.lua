---@class lazyvim.util.pick
---@overload fun(command:string, opts?:lazyvim.util.pick.Opts): fun()
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.wrap(...)
  end,
})

---@class lazyvim.util.pick.Opts: table<string, any>
---@field root? boolean
---@field cwd? string
---@field buf? number
---@field show_untracked? boolean

---@type table<string, string>
M.commands = {
  files = "find_files",
}

---@param command? string
---@param opts? lazyvim.util.pick.Opts
function M.open(command, opts)
  command = command or "auto"
  opts = opts or {}

  opts = vim.deepcopy(opts)

  if type(opts.cwd) == "boolean" then
    LazyVim.warn("LazyVim.pick: opts.cwd should be a string or nil")
    opts.cwd = nil
  end

  if not opts.cwd and opts.root ~= false then
    opts.cwd = LazyVim.root({ buf = opts.buf })
  end

  local cwd = opts.cwd or vim.uv.cwd()
  if command == "auto" then
    command = "files"
    if
      vim.uv.fs_stat(cwd .. "/.git")
      and not vim.uv.fs_stat(cwd .. "/.ignore")
      and not vim.uv.fs_stat(cwd .. "/.rgignore")
    then
      command = "git_files"
      opts.show_untracked = opts.show_untracked ~= false
    end
  end
  command = M.commands[command] or command
  M._open(command, opts)
end

---@param command? string
---@param opts? lazyvim.util.pick.Opts
function M.wrap(command, opts)
  opts = opts or {}
  return function()
    M.open(command, vim.deepcopy(opts))
  end
end

---@param command string
---@param opts? lazyvim.util.pick.Opts
function M._open(command, opts)
  return LazyVim.telescope.open(command, opts)
end

function M.config_files()
  return M.wrap("files", { cwd = vim.fn.stdpath("config") })
end

return M
