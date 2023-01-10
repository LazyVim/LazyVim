-- Ugly code to generate some things for the readme
local Util = require("lazy.util")

local M = {}
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h:h:h")

---@return ReadmeBlock
function M.keymaps()
  local keymap_set = vim.keymap.set
  ---@type table<string,{mode?:string|string[], keys:string, desc?:string, i:number, group:string}>
  local keymaps = {}
  ---@type string
  local group = nil
  ---@type string[]
  local groups = {}
  local function map(mode, lhs, rhs, opts)
    if not (opts and opts.desc) then
      return
    end
    if not vim.tbl_contains(groups, group) then
      groups[#groups + 1] = group
    end
    mode = mode == nil and { "n", "v", "o" } or type(mode) == "string" and { mode } or mode
    local desc = opts and opts.desc or ""
    local key = lhs .. desc .. group
    if keymaps[key] then
      vim.list_extend(keymaps[key].mode, mode)
    else
      keymaps[key] = { mode = mode, keys = lhs, desc = desc, i = vim.tbl_count(keymaps), group = group }
    end
  end
  vim.keymap.set = map

  group = "General"
  dofile(root .. "/lua/lazyvim/config/keymaps.lua")
  group = "LSP"
  local lsp = dofile(root .. "/lua/lazyvim/plugins/lsp/keymaps.lua")
  lsp.has = function()
    return true
  end
  lsp.on_attach({ name = "foobar" })

  vim.keymap.set = keymap_set

  group = "Plugins"

  local core = require("lazy.core.plugin").Spec.new({ import = "lazyvim.plugins" })
  Util.foreach(core.plugins, function(name, plugin)
    for _, key in ipairs(plugin.keys or {}) do
      if type(key) == "table" and key.desc then
        local desc = key.desc or ""
        desc = ("[%s](%s)"):format(plugin.name, plugin.url) .. " " .. desc
        map(key.mode or "n", key[1], key[2], { desc = desc })
      end
    end
  end)

  ---@type string[]
  local lines = {}

  for _, group in ipairs(groups) do
    lines[#lines + 1] = "<details><summary>" .. group .. "</summary>"
    lines[#lines + 1] = ""
    vim.list_extend(lines, { "| Key | Description | Mode |", "| --- | --- | --- |" })
    local mappings = vim.tbl_filter(function(m)
      return m.group == group and m.desc
    end, keymaps)

    table.sort(mappings, function(a, b)
      return a.i < b.i
    end)

    for _, m in ipairs(mappings) do
      lines[#lines + 1] = "| ``"
        .. m.keys:gsub("|", "\\|"):gsub("`$", "` ")
        .. "`` | "
        .. m.desc
        .. " | "
        .. table.concat(
          vim.tbl_map(function(mode)
            return "**" .. mode .. "**"
          end, m.mode),
          ", "
        )
        .. " |"
    end
    lines[#lines + 1] = ""
    lines[#lines + 1] = "</details>"
    lines[#lines + 1] = ""
  end
  return { content = table.concat(lines, "\n") }
end

function M.update()
  local Docs = require("lazy.docs")
  ---@type table<string, ReadmeBlock>
  local data = {
    keymaps = M.keymaps(),
    config = Docs.extract("lua/lazyvim/config/init.lua", "\nlocal defaults = ({.-\n})"),
  }

  local core = require("lazy.core.plugin").Spec.new({ import = "lazyvim.plugins" })

  ---@type string[]
  local plugins = {
    "<details><summary>Core</summary>",
    "",
    Docs.plugins(core.plugins).content,
    "",
    "</details>",
    "",
  }

  Util.walk(root .. "/lua/lazyvim/plugins/extras", function(path, name, type)
    if type == "file" and name:find("%.lua$") then
      local modname = path:gsub(".*/lua/", ""):gsub("/", "."):gsub("%.lua$", "")
      local spec = require("lazy.core.plugin").Spec.new({ import = modname })
      spec:fix_disabled()
      vim.list_extend(plugins, {
        ("<details><summary>Extras: <code>%s</code></summary>"):format(modname:gsub(".*extras%.", "")),
        "",
        ([[
To use this, add it to your **lazy.nvim** imports:

```lua
require("lazy").setup({
  spec = {
    { "folke/LazyVim", import = "lazyvim.plugins" },
    { import = "%s" },
    { import = "plugins" },
  },
})
```
]]):format(modname),
        Docs.plugins(spec.plugins).content,
        "",
        "</details>",
        "",
      })
    end
  end)
  data.plugins = { content = table.concat(plugins, "\n") }
  local examples = vim.fn.fnamemodify(root .. "/../LazyVim-starter/lua/plugins/example.lua", ":p")
  data.examples = Util.read_file(examples):gsub("^[^\n]+\n[^\n]+\n[^\n]+\n", "")
  Docs.save(data)
end

M.update()

return M
