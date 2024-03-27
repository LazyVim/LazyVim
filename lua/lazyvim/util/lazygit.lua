---@class lazyvim.util.lazygit
---@field config_dir? string
---@overload fun(cmd: string|string[], opts: LazyTermOpts): LazyFloat
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

M.theme_path = vim.fn.stdpath("cache") .. "/lazygit-theme.yml"

-- re-create config file on startup
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
  if vim.g.lazygit_theme ~= nil then
    LazyVim.deprecate("vim.g.lazygit_theme", "vim.g.lazygit_config")
  end

  opts = vim.tbl_deep_extend("force", {}, {
    esc_esc = false,
    ctrl_hjkl = false,
  }, opts or {})

  local cmd = { "lazygit" }
  vim.list_extend(cmd, opts.args or {})

  if vim.g.lazygit_config then
    if M.dirty then
      M.update_config()
    end

    if not M.config_dir then
      local Process = require("lazy.manage.process")
      local ok, lines = pcall(Process.exec, { "lazygit", "-cd" })
      if ok then
        M.config_dir = lines[1]
        vim.env.LG_CONFIG_FILE = M.config_dir .. "/config.yml" .. "," .. M.theme_path
      else
        ---@diagnostic disable-next-line: cast-type-mismatch
        ---@cast lines string
        LazyVim.error(
          { "Failed to get **lazygit** config directory.", "Will not apply **lazygit** config.", "", "# Error:", lines },
          { title = "lazygit" }
        )
      end
    end
  end

  return LazyVim.terminal(cmd, opts)
end

function M.set_ansi_color(idx, color)
  io.write(("\27]4;%d;%s\7"):format(idx, color))
end

function M.update_config()
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
    selectedLineBgColor = { LazyVim.ui.color("Visual", true) }, -- set to `default` to have no background colour
    unstagedChangesColor = { "red" },
  }
  local config = [[
os:
  editPreset: "nvim-remote"
gui:
  nerdFontsVersion: 3
  theme:
]]

  ---@type string[]
  local lines = {}
  for k, v in pairs(theme) do
    lines[#lines + 1] = ("   %s:"):format(k)
    for _, c in ipairs(v) do
      lines[#lines + 1] = ("     - %q"):format(c)
    end
  end
  config = config .. table.concat(lines, "\n")
  require("lazy.util").write_file(M.theme_path, config)
  M.dirty = false
end

return M
