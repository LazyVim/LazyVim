---@class lazyvim.util.lazygit
---@field config_dir? string
---@overload fun(cmd: string|string[], opts: LazyTermOpts): LazyFloat
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

M.theme_path = vim.fn.stdpath("cache") .. "/lazygit-theme.yml"

-- re-create theme file on startup
M.dirty = true

-- re-create theme file on ColorScheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    M.dirty = true
  end,
})

-- Opens lazygit
---@param opts? LazyTermOpts | {args?: string[]}
function M.open(opts)
  opts = vim.tbl_deep_extend("force", {}, {
    esc_esc = false,
    ctrl_hjkl = false,
  }, opts or {})
  local cmd = { "lazygit" }
  if vim.g.lazygit_theme then
    if M.dirty then
      M.update_theme()
    end
    M.config_dir = M.config_dir or vim.trim(vim.fn.system("lazygit -cd"))
    vim.env.LG_CONFIG_FILE = M.config_dir .. "/config.yml" .. "," .. M.theme_path
  end
  vim.list_extend(cmd, opts.args or {})
  return LazyVim.terminal(cmd, opts)
end

function M.set_ansi_color(idx, color)
  io.write(("\27]4;%d;%s\7"):format(idx, color))
end

function M.update_theme()
  -- LazyGit uses color 241 a lot, so also set it to a nice color
  -- pcall, since some terminals don't like this
  pcall(M.set_ansi_color, 241, LazyVim.ui.color("Special") or "blue")

  local theme = {
    activeBorderColor = { LazyVim.ui.color("MatchParen") or "orange", "bold" },
    cherryPickedCommitBgColor = { "cyan" },
    cherryPickedCommitFgColor = { "blue" },
    defaultFgColor = { "default" },
    inactiveBorderColor = { LazyVim.ui.color("FloatBorder") or "blue" },
    optionsTextColor = { "blue" },
    searchingActiveBorderColor = { LazyVim.ui.color("MatchParen") or "orange", "bold" },
    selectedLineBgColor = { LazyVim.ui.color("CursorLine", true) }, -- set to `default` to have no background colour
    unstagedChangesColor = { "red" },
  }
  ---@type string[]
  local lines = {}
  lines[#lines + 1] = "gui:"
  lines[#lines + 1] = " theme:"
  for k, v in pairs(theme) do
    lines[#lines + 1] = ("   %s:"):format(k)
    for _, c in ipairs(v) do
      lines[#lines + 1] = ("     - %q"):format(c)
    end
  end
  local config = table.concat(lines, "\n")
  require("lazy.util").write_file(M.theme_path, config)
  M.dirty = false
end

return M
