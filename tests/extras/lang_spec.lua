---@module 'luassert'

local Plugin = require("lazy.core.plugin")
_G.LazyVim = require("lazyvim.util")

describe("Extra", function()
  local Config = require("lazy.core.config")
  assert(vim.tbl_count(Config.plugins) > 0, "Lazy not properly setup")

  ---@type {modname:string, modpath:string}[]
  local extras = vim.tbl_map(
    ---@param path string
    function(path)
      local modname = path:sub(5):gsub("%.lua$", ""):gsub("/", ".")
      return { modname = modname, modpath = path }
    end,
    vim.fs.find(function(name)
      return name:match("%.lua$")
    end, { limit = math.huge, type = "file", path = "lua/lazyvim/plugins/extras" })
  )

  for _, extra in ipairs(extras) do
    it(extra.modname .. " is valid", function()
      local mod = require(extra.modname)
      local spec = Plugin.Spec.new(mod, { optional = true })
      assert.is_not_nil(mod)
      assert(#spec.notifs == 0, "Invalid spec: " .. vim.inspect(spec.notifs))

      if extra.modname:find("%.lang%.") then
        assert(mod.recommended, "`recommended` not set for " .. extra.modname)
      end
    end)
  end
end)
