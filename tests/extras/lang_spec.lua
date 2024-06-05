---@module 'luassert'

local Plugin = require("lazy.core.plugin")
_G.LazyVim = require("lazyvim.util")

describe("Extra", function()
  local Config = require("lazy.core.config")
  local Loader = require("lazy.core.loader")
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
  local servers = require("mason-lspconfig.mappings.server").package_to_lspconfig

  local tsspec = Plugin.Spec.new({
    import = "lazyvim.plugins.treesitter",
  }, { optional = true })

  local tsopts = Plugin.values(tsspec.plugins["nvim-treesitter"], "opts", false)

  local tsensure = tsopts.ensure_installed
  assert(type(tsensure) == "table", "No ensure_installed in nvim-treesitter spec")

  for _, extra in ipairs(extras) do
    it(extra.modname .. " is valid", function()
      local mod = require(extra.modname)
      local spec = Plugin.Spec.new({
        { "williamboman/mason.nvim", opts = { ensure_installed = {} } },
        { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
        mod,
      }, { optional = true })
      assert.is_not_nil(mod)
      assert(#spec.notifs == 0, "Invalid spec: " .. vim.inspect(spec.notifs))

      if extra.modname:find("%.lang%.") then
        assert(mod.recommended, "`recommended` not set for " .. extra.modname)
        local mason = spec.plugins["mason.nvim"]
        local opts = Plugin.values(mason, "opts", false)
        for _, v in ipairs(opts.ensure_installed) do
          assert(
            not servers[v],
            "LSP server " .. v .. " is installed automatically. Please remove from the mason.nvim spec"
          )
        end
        local ts = spec.plugins["nvim-treesitter"]
        opts = Plugin.values(mason, "opts", false)
        for _, v in ipairs(opts.ensure_installed) do
          assert(
            not vim.tbl_contains(tsensure, v),
            "TS lang " .. v .. " is already a default. Please remove from the mason.nvim spec"
          )
        end
      end
    end)
  end
end)
