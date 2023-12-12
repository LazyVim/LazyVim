local Config = require("lazyvim.config")

-- Some extras need to be loaded before others
local prios = {
  ["lazyvim.plugins.extras.editor.aerial"] = 100,
  ["lazyvim.plugins.extras.editor.symbols-outline"] = 100,
  ["lazyvim.plugins.extras.test.core"] = 1,
  ["lazyvim.plugins.extras.dap.core"] = 1,
}

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
