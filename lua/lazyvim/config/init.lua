---@class LazyVimConfig: LazyVimOptions
local M = {}

M.lazy_version = ">=10.8.0"
M.use_lazy_file = true
M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

---@class LazyVimOptions
local defaults = {
  -- colorscheme can be a string like `catppuccin` or a function that will load the colorscheme
  ---@type string|fun()
  colorscheme = function()
    require("tokyonight").load()
  end,
  -- load the default settings
  defaults = {
    autocmds = true, -- lazyvim.config.autocmds
    keymaps = true, -- lazyvim.config.keymaps
    -- lazyvim.config.options can't be configured here since that's loaded before lazyvim setup
    -- if you want to disable loading options, add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua
  },
  -- icons used by other plugins
  icons = {
    misc = {
      dots = "󰇘",
    },
    dap = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    kinds = {
      Array = " ",
      Boolean = " ",
      Class = " ",
      Codeium = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Copilot = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Key = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Namespace = " ",
      Null = " ",
      Number = " ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      String = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    },
  },
}

M.renames = {
  ["windwp/nvim-spectre"] = "nvim-pack/nvim-spectre",
  ["jose-elias-alvarez/null-ls.nvim"] = "nvimtools/none-ls.nvim",
  ["null-ls.nvim"] = "none-ls.nvim",
}

---@type LazyVimOptions
local options

---@param lines {[1]:string, [2]:string}[]
function M.msg(lines)
  vim.cmd([[clear]])
  vim.api.nvim_echo(lines, true, {})
  vim.fn.getchar()
end

---@param opts? LazyVimOptions
function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}

  if vim.fn.has("nvim-0.9.0") == 0 then
    M.msg({
      {
        "LazyVim requires Neovim >= 0.9.0\n",
        "ErrorMsg",
      },
      { "Press any key to exit", "MoreMsg" },
    })
    vim.cmd([[quit]])
    return
  end

  if not M.has() then
    M.msg({
      {
        "LazyVim requires lazy.nvim " .. M.lazy_version .. "\n",
        "WarningMsg",
      },
      { "Press any key to attempt an upgrade", "MoreMsg" },
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        require("lazy").update({ plugins = { "lazy.nvim" }, wait = true })
        M.msg({
          {
            "**lazy.nvim** has been upgraded.\nPlease restart **Neovim**",
            "WarningMsg",
          },
        })
      end,
    })
  end

  -- autocmds can be loaded lazily when not opening a file
  local lazy_autocmds = vim.fn.argc(-1) == 0
  if not lazy_autocmds then
    M.load("autocmds")
  end

  local group = vim.api.nvim_create_augroup("LazyVim", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    callback = function()
      if lazy_autocmds then
        M.load("autocmds")
      end
      M.load("keymaps")
    end,
  })

  if M.use_lazy_file then
    M.lazy_file()
  end

  require("lazy.core.util").try(function()
    if type(M.colorscheme) == "function" then
      M.colorscheme()
    else
      vim.cmd.colorscheme(M.colorscheme)
    end
  end, {
    msg = "Could not load your colorscheme",
    on_error = function(msg)
      require("lazy.core.util").error(msg)
      vim.cmd.colorscheme("habamax")
    end,
  })
end

-- Properly load file based plugins without blocking the UI
function M.lazy_file()
  local events = {} ---@type {event: string, buf: number, data?: any}[]

  local function load()
    if #events == 0 then
      return
    end
    local Event = require("lazy.core.handler.event")
    local Util = require("lazy.core.util")
    vim.api.nvim_del_augroup_by_name("lazy_file")

    Util.track({ event = "LazyVim.lazy_file" })

    ---@type table<string,string[]>
    local skips = {}
    for _, event in ipairs(events) do
      skips[event.event] = skips[event.event] or Event.get_augroups(event.event)
    end

    vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile", modeline = false })
    for _, event in ipairs(events) do
      Event.trigger({
        event = event.event,
        exclude = skips[event.event],
        data = event.data,
        buf = event.buf,
      })
      if vim.bo[event.buf].filetype then
        Event.trigger({
          event = "FileType",
          buf = event.buf,
        })
      end
    end
    vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })
    events = {}
    Util.track()
  end

  -- schedule wrap so that nested autocmds are executed
  -- and the UI can continue rendering without blocking
  load = vim.schedule_wrap(load)

  vim.api.nvim_create_autocmd(M.lazy_file_events, {
    group = vim.api.nvim_create_augroup("lazy_file", { clear = true }),
    callback = function(event)
      table.insert(events, event)
      load()
    end,
  })
end

---@param range? string
function M.has(range)
  local Semver = require("lazy.manage.semver")
  return Semver.range(range or M.lazy_version):matches(require("lazy.core.config").version or "0.0.0")
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local Util = require("lazy.core.util")
  local function _load(mod)
    Util.try(function()
      require(mod)
    end, {
      msg = "Failed loading " .. mod,
      on_error = function(msg)
        local info = require("lazy.core.cache").find(mod)
        if info == nil or (type(info) == "table" and #info == 0) then
          return
        end
        Util.error(msg)
      end,
    })
  end
  -- always load lazyvim, then user file
  if M.defaults[name] or name == "options" then
    _load("lazyvim.config." .. name)
  end
  _load("config." .. name)
  if vim.bo.filetype == "lazy" then
    -- HACK: LazyVim may have overwritten options of the Lazy ui, so reset this here
    vim.cmd([[do VimResized]])
  end
  local pattern = "LazyVim" .. name:sub(1, 1):upper() .. name:sub(2)
  vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

M.did_init = false
function M.init()
  if not M.did_init then
    M.did_init = true
    local plugin = require("lazy.core.config").spec.plugins.LazyVim
    if plugin then
      vim.opt.rtp:append(plugin.dir)
    end

    M.use_lazy_file = M.use_lazy_file and vim.fn.argc(-1) > 0
    ---@diagnostic disable-next-line: undefined-field
    M.use_lazy_file = M.use_lazy_file and require("lazy.core.handler.event").trigger_events == nil

    -- delay notifications till vim.notify was replaced or after 500ms
    require("lazyvim.util").lazy_notify()

    -- load options here, before lazy init while sourcing plugin modules
    -- this is needed to make sure options will be correctly applied
    -- after installing missing plugins
    require("lazyvim.config").load("options")
    local Plugin = require("lazy.core.plugin")
    local add = Plugin.Spec.add
    ---@diagnostic disable-next-line: duplicate-set-field
    Plugin.Spec.add = function(self, plugin, ...)
      if type(plugin) == "table" then
        if M.renames[plugin[1]] then
          require("lazy.core.util").warn(
            ("Plugin `%s` was renamed to `%s`.\nPlease update your config for `%s`"):format(
              plugin[1],
              M.renames[plugin[1]],
              self.importing or "LazyVim"
            ),
            { title = "LazyVim" }
          )
          plugin[1] = M.renames[plugin[1]]
        end
        if not M.use_lazy_file and plugin.event then
          if plugin.event == "LazyFile" then
            plugin.event = M.lazy_file_events
          elseif type(plugin.event) == "table" then
            local events = {} ---@type string[]
            for _, event in ipairs(plugin.event) do
              if event == "LazyFile" then
                vim.list_extend(events, M.lazy_file_events)
              else
                events[#events + 1] = event
              end
            end
          end
        end
      end
      return add(self, plugin, ...)
    end

    -- Add support for the LazyFile event
    local Event = require("lazy.core.handler.event")
    local _event = Event._event
    ---@diagnostic disable-next-line: duplicate-set-field
    Event._event = function(self, value)
      return value == "LazyFile" and "User LazyFile" or _event(self, value)
    end
  end
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end
    ---@cast options LazyVimConfig
    return options[key]
  end,
})

return M
