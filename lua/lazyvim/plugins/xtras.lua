local Config = require("lazyvim.config")

-- Some extras need to be loaded before others
local prios = {
  ["editor.aerial"] = 100,
  ["editor.symbols-outline"] = 100,
  ["test.core"] = 1,
  ["dap.core"] = 1,
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
  return { import = "lazyvim.plugins.extras." .. extra }
end, Config.json.data.extras)
