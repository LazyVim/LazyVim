---@class lazyvim.util.lazygit
---@field config_dir? string
---@overload fun(cmd: string|string[], opts: LazyTermOpts): LazyFloat
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

---@alias LazyGitColor {fg?:string, bg?:string, bold?:boolean}

---@class LazyGitTheme: table<number, LazyGitColor>
---@field activeBorderColor LazyGitColor
---@field cherryPickedCommitBgColor LazyGitColor
---@field cherryPickedCommitFgColor LazyGitColor
---@field defaultFgColor LazyGitColor
---@field inactiveBorderColor LazyGitColor
---@field optionsTextColor LazyGitColor
---@field searchingActiveBorderColor LazyGitColor
---@field selectedLineBgColor LazyGitColor
---@field unstagedChangesColor LazyGitColor
M.theme = {
  [241] = { fg = "Special" },
  activeBorderColor = { fg = "MatchParen", bold = true },
  cherryPickedCommitBgColor = { fg = "Identifier" },
  cherryPickedCommitFgColor = { fg = "Function" },
  defaultFgColor = { fg = "Normal" },
  inactiveBorderColor = { fg = "FloatBorder" },
  optionsTextColor = { fg = "Function" },
  searchingActiveBorderColor = { fg = "MatchParen", bold = true },
  selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
  unstagedChangesColor = { fg = "DiagnosticError" },
}

M.theme_path = LazyVim.norm(vim.fn.stdpath("cache") .. "/lazygit-theme.yml")

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
        vim.env.LG_CONFIG_FILE = LazyVim.norm(M.config_dir .. "/config.yml" .. "," .. M.theme_path)
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

---@param v LazyGitColor
---@return string[]
function M.get_color(v)
  ---@type string[]
  local color = {}
  if v.fg then
    color[1] = LazyVim.ui.color(v.fg)
  elseif v.bg then
    color[1] = LazyVim.ui.color(v.bg, true)
  end
  if v.bold then
    table.insert(color, "bold")
  end
  return color
end

function M.update_config()
  ---@type table<string, string[]>
  local theme = {}

  for k, v in pairs(M.theme) do
    if type(k) == "number" then
      local color = M.get_color(v)
      -- LazyGit uses color 241 a lot, so also set it to a nice color
      -- pcall, since some terminals don't like this
      pcall(M.set_ansi_color, k, color[1])
    else
      theme[k] = M.get_color(v)
    end
  end

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

---@param opts? {count?: number}|LazyCmdOptions
function M.blame_line(opts)
  opts = vim.tbl_deep_extend("force", {
    count = 3,
    filetype = "git",
    size = {
      width = 0.6,
      height = 0.6,
    },
    border = "rounded",
  }, opts or {})
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1]
  local file = vim.api.nvim_buf_get_name(0)
  local root = LazyVim.root.detectors.pattern(0, { ".git" })[1] or "."
  local cmd = { "git", "-C", root, "log", "-n", opts.count, "-u", "-L", line .. ",+1:" .. file }
  return require("lazy.util").float_cmd(cmd, opts)
end

-- stylua: ignore
M.remote_patterns = {
  { "^(https?://.*)%.git$"              , "%1" },
  { "^git@(.+):(.+)%.git$"              , "https://%1/%2" },
  { "^git@(.+):(.+)$"                   , "https://%1/%2" },
  { "^git@(.+)/(.+)$"                   , "https://%1/%2" },
  { "^ssh://git@(.*)$"                  , "https://%1" },
  { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
  { "^https://%w*@(.*)"                 , "https://%1" },
  { "^git@(.*)"                         , "https://%1" },
  { ":%d+"                              , "" },
  { "%.git$"                            , "" },
}

---@param remote string
function M.get_url(remote)
  local ret = remote
  for _, pattern in ipairs(M.remote_patterns) do
    ret = ret:gsub(pattern[1], pattern[2])
  end

  if ret:find("https://") == 1 then
    return ret
  end

  --- @param url string
  local function getRemoteURLFromSSH(url)
    local transformedUrl = ""
    local SSHConfigPath = vim.env.HOME .. "/.ssh/config"

    -- Return the original URL if SSH config is not found or not readable
    if not vim.uv.fs_access(SSHConfigPath, "R") then
      return
    end

    -- Handle SSH config remotes
    local file = io.open(SSHConfigPath, "r")

    -- Return the original URL if unable to read SSH config file
    if not file then
      return
    end

    local currentHost, hostGroup = "", {}
    for line in file:lines() do
      line = line:match("^%s*(.-)%s*$")

      if line ~= "" and not line:match("^#") then
        local key, value = line:match("^(%S+)%s+(.+)$")

        if key:lower() == "host" then
          -- Process the URL before parsing the next group of hosts. If there is a match, we can replace the string and break early.
          if currentHost ~= "" and currentHost ~= value and url:match(currentHost .. ":") then
            -- If the username is specified, we do not need to replace it; otherwise, replace the username with "git".
            local searchString = hostGroup[currentHost].User and currentHost .. ":" or "git@" .. currentHost .. ":"
            local destinationURL = string.format("https://%s/", hostGroup[currentHost].HostName)
            transformedUrl = url:gsub(searchString, destinationURL):gsub("%.git$", "")
            break
          end
          -- Setup group of host
          currentHost = value
          hostGroup[currentHost] = {}
        elseif currentHost then
          hostGroup[currentHost][key] = value
        end
      end
    end

    file:close()
    return transformedUrl
  end

  return getRemoteURLFromSSH(ret) or ("https://%s"):format(ret)
end

function M.browse()
  local lines = require("lazy.manage.process").exec({ "git", "remote", "-v" })
  local remotes = {} ---@type {name:string, url:string}[]

  for _, line in ipairs(lines) do
    local name, remote = line:match("(%S+)%s+(%S+)%s+%(fetch%)")
    if name and remote then
      local url = M.get_url(remote)
      if url then
        table.insert(remotes, { name = name, url = url })
      end
    end
  end

  local function open(remote)
    if remote then
      LazyVim.info(("Opening [%s](%s)"):format(remote.name, remote.url))
      if vim.fn.has("nvim-0.10") == 0 then
        require("lazy.util").open(remote.url, { system = true })
        return
      end
      vim.ui.open(remote.url)
    end
  end

  if #remotes == 0 then
    return LazyVim.error("No git remotes found")
  elseif #remotes == 1 then
    return open(remotes[1])
  end

  vim.ui.select(remotes, {
    prompt = "Select remote to browse",
    format_item = function(item)
      return item.name .. (" "):rep(8 - #item.name) .. " 🔗 " .. item.url
    end,
  }, open)
end

return M
