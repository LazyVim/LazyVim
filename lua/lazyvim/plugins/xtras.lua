-- Some extras need to be loaded before others
local prios = {
  ["lazyvim.plugins.extras.test.core"] = 1,
  ["lazyvim.plugins.extras.dap.core"] = 1,
  ["lazyvim.plugins.extras.ui.edgy"] = 2,
  ["lazyvim.plugins.extras.lang.typescript"] = 5,
  ["lazyvim.plugins.extras.formatting.prettier"] = 10,
  -- default priority is 50
  ["lazyvim.plugins.extras.editor.aerial"] = 100,
  ["lazyvim.plugins.extras.editor.outline"] = 100,
}

---@type string[]
local extras = LazyVim.dedup(LazyVim.config.json.data.extras)

local version = vim.version()
local v = version.major .. "_" .. version.minor

local compat = { "0_9" }

LazyVim.plugin.save_core()
if vim.tbl_contains(compat, v) then
  table.insert(extras, 1, "lazyvim.plugins.compat.nvim-" .. v)
end

table.sort(extras, function(a, b)
  local pa = prios[a] or 50
  local pb = prios[b] or 50
  if pa == pb then
    return a < b
  end
  return pa < pb
end)

---@param extra string
return vim.tbl_map(function(extra)
  return { import = extra }
end, extras)
