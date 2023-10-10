local Plugin = require("lazy.core.plugin")
local Util = require("lazyvim.util")

---@class lazyvim.util.plugin
local M = {}

M.use_lazy_file = true
M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

---@type table<string, string>
M.deprecated_extras = {
  ["lazyvim.plugins.extras.formatting.conform"] = "`conform.nvim` is now the default **LazyVim** formatter.",
  ["lazyvim.plugins.extras.linting.nvim-lint"] = "`nvim-lint` is now the default **LazyVim** linter.",
  ["lazyvim.plugins.extras.ui.dashboard"] = "`dashboard.nvim` is now the default **LazyVim** starter.",
}

---@type table<string, string>
M.renames = {
  ["windwp/nvim-spectre"] = "nvim-pack/nvim-spectre",
  ["jose-elias-alvarez/null-ls.nvim"] = "nvimtools/none-ls.nvim",
  ["null-ls.nvim"] = "none-ls.nvim",
}

-- Properly load file based plugins without blocking the UI
function M.lazy_file()
  M.use_lazy_file = M.use_lazy_file and vim.fn.argc(-1) > 0
  ---@diagnostic disable-next-line: undefined-field
  M.use_lazy_file = M.use_lazy_file and require("lazy.core.handler.event").trigger_events == nil
  M.use_lazy_file = false

  M.fix_lazy_file()

  if not M.use_lazy_file then
    return
  end

  local events = {} ---@type {event: string, buf: number, data?: any}[]

  local function load()
    if #events == 0 then
      return
    end
    local Event = require("lazy.core.handler.event")
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

function M.fix_imports()
  local import = Plugin.Spec.import
  ---@diagnostic disable-next-line: duplicate-set-field
  function Plugin.Spec:import(spec)
    local dep = M.deprecated_extras[spec and spec.import]
    if dep then
      dep = dep .. "\n" .. "Please remove the extra to hide this warning."
      Util.warn(dep, { title = "LazyVim", once = true, stacktrace = true, stacklevel = 6 })
      return
    end
    return import(self, spec)
  end
end

function M.fix_renames()
  local add = Plugin.Spec.add
  ---@diagnostic disable-next-line: duplicate-set-field
  Plugin.Spec.add = function(self, plugin, ...)
    if type(plugin) == "table" then
      if M.renames[plugin[1]] then
        Util.warn(
          ("Plugin `%s` was renamed to `%s`.\nPlease update your config for `%s`"):format(
            plugin[1],
            M.renames[plugin[1]],
            self.importing or "LazyVim"
          ),
          { title = "LazyVim" }
        )
        plugin[1] = M.renames[plugin[1]]
      end
    end
    return add(self, plugin, ...)
  end
end

function M.fix_lazy_file()
  local Config = require("lazyvim.config")
  -- Add support for the LazyFile event
  local Handler = require("lazy.core.handler")
  local Event = require("lazy.core.handler.event")
  if M.use_lazy_file then
    local _event = Event._event
    ---@diagnostic disable-next-line: duplicate-set-field
    Event._event = function(self, value)
      return value == "LazyFile" and "User LazyFile" or _event(self, value)
    end
  else
    ---@param plugin LazyPlugin
    function Event:values(plugin)
      local ret = Handler.values(self, plugin)
      if ret["LazyFile"] or ret["User LazyFile"] then
        for _, event in ipairs(M.lazy_file_events) do
          ret[event] = event
        end
        ret["LazyFile"] = nil
        ret["User LazyFile"] = nil
      end
      return ret
    end
  end
end

return M
