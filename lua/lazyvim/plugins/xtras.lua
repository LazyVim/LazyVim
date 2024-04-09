local Config = require("lazyvim.config")

-- Some extras need to be loaded before others
local prios = {
  ["lazyvim.plugins.extras.editor.aerial"] = 100,
  ["lazyvim.plugins.extras.editor.outline"] = 100,
  ["lazyvim.plugins.extras.editor.trouble-v3"] = 100,
  ["lazyvim.plugins.extras.test.core"] = 1,
  ["lazyvim.plugins.extras.dap.core"] = 1,
}

local used = {} ---@type table<string, boolean>

---@type string[]
Config.json.data.extras = vim.tbl_filter(function(extra)
  if used[extra] then
    return false
  end
  used[extra] = true
  return true
end, Config.json.data.extras)

table.sort(Config.json.data.extras, function(a, b)
  local pa = prios[a] or 10
  local pb = prios[b] or 10
  if pa == pb then
    return a < b
  end
  return pa < pb
end)

---@param extra string
return vim.tbl_map(function(extra)
  return { import = extra }
end, Config.json.data.extras)
