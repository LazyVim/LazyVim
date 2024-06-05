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
  local lsp_to_pkg = require("mason-lspconfig.mappings.server").lspconfig_to_package
  local pkg_to_lsp = require("mason-lspconfig.mappings.server").package_to_lspconfig

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
        local lspconfig = spec.plugins["nvim-lspconfig"]

        if lspconfig then
          local lspconfig_opts = Plugin.values(lspconfig, "opts", false)
          local mason = spec.plugins["mason.nvim"]
          local mason_opts = Plugin.values(mason, "opts", false)

          for lsp in pairs(lspconfig_opts.servers or {}) do
            local lsp_pkg = pkg_to_lsp[lsp]
            assert(
              not (lsp_pkg and vim.tbl_contains(mason_opts.ensure_installed, lsp_pkg)),
              "LSP server "
                .. lsp
                .. " with pkg "
                .. (lsp_pkg or "foo")
                .. " is installed automatically. Please remove from the mason.nvim spec"
            )
          end
        end
        local ts = spec.plugins["nvim-treesitter"]
        local opts = Plugin.values(ts, "opts", false)
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
