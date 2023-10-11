---@class lazyvim.util.inject
local M = {}

---@generic A: any
---@generic B: any
---@generic C: any
---@generic F: function
---@param fn F|fun(a:A, b:B, c:C)
---@param wrapper fun(a:A, b:B, c:C): boolean?
---@return F
function M.args(fn, wrapper)
  return function(...)
    if wrapper(...) == false then
      return
    end
    return fn(...)
  end
end

return M
