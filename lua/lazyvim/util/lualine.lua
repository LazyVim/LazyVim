local Util = require("lazyvim.util")

---@class lazyvim.util.lualine
local M = {}

function M.cmp_source(name, icon)
  local started = false
  local function status()
    if not package.loaded["cmp"] then
      return
    end
    for _, s in ipairs(require("cmp").core.sources) do
      if s.name == name then
        if s.source:is_available() then
          started = true
        else
          return started and "error" or nil
        end
        if s.status == s.SourceStatus.FETCHING then
          return "pending"
        end
        return "ok"
      end
    end
  end

  local colors = {
    ok = Util.ui.fg("Special"),
    error = Util.ui.fg("DiagnosticError"),
    pending = Util.ui.fg("DiagnosticWarn"),
  }

  return {
    function()
      return icon or require("lazyvim.config").icons.kinds[name:sub(1, 1):upper() .. name:sub(2)]
    end,
    cond = function()
      return status() ~= nil
    end,
    color = function()
      return colors[status()] or colors.ok
    end,
  }
end

return M
