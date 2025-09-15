-- Some extras need to be loaded before others
local prios = {
  ["lazyvim.plugins.extras.test.core"] = 1,
  ["lazyvim.plugins.extras.dap.core"] = 1,
  ["lazyvim.plugins.extras.coding.nvim-cmp"] = 2,
  ["lazyvim.plugins.extras.editor.neo-tree"] = 2,
  ["lazyvim.plugins.extras.ui.edgy"] = 3,
  ["lazyvim.plugins.extras.lang.typescript"] = 5,
  ["lazyvim.plugins.extras.coding.blink"] = 5,
  ["lazyvim.plugins.extras.formatting.prettier"] = 10,
  -- default core extra priority is 20
  -- default priority is 50
  ["lazyvim.plugins.extras.editor.aerial"] = 100,
  ["lazyvim.plugins.extras.editor.outline"] = 100,
  ["lazyvim.plugins.extras.ui.alpha"] = 19,
  ["lazyvim.plugins.extras.ui.dashboard-nvim"] = 19,
  ["lazyvim.plugins.extras.ui.mini-starter"] = 19,
}

if vim.g.xtras_prios then
  prios = vim.tbl_deep_extend("force", prios, vim.g.xtras_prios or {})
end

local extras = {} ---@type string[]
local defaults = LazyVim.config.get_defaults()

-- Add extras from LazyExtras that are not disabled
for _, extra in ipairs(LazyVim.config.json.data.extras) do
  local def = defaults[extra]
  if not (def and def.enabled == false) then
    extras[#extras + 1] = extra
  end
end

-- Add default extras
for name, extra in pairs(defaults) do
  if extra.enabled then
    prios[name] = prios[name] or 20
    extras[#extras + 1] = name
  end
end

---@type string[]
extras = LazyVim.dedup(extras)

LazyVim.plugin.save_core()
if vim.g.vscode then
  table.insert(extras, 1, "lazyvim.plugins.extras.vscode")
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
