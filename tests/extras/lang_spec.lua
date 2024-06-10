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

  local ignore = { "lazyvim.plugins.extras.ui.treesitter-rewrite" }
  extras = vim.tbl_filter(function(extra)
    return not vim.tbl_contains(ignore, extra.modname)
  end, extras)

  local lsp_to_pkg = require("mason-lspconfig.mappings.server").lspconfig_to_package

  local tsspec = Plugin.Spec.new({
    import = "lazyvim.plugins.treesitter",
  }, { optional = true })

  local tsopts = Plugin.values(tsspec.plugins["nvim-treesitter"], "opts", false)

  local tsensure = tsopts.ensure_installed
  assert(type(tsensure) == "table", "No ensure_installed in nvim-treesitter spec")

  for _, extra in ipairs(extras) do
    local name = extra.modname:sub(#"lazyvim.plugins.extras" + 2)
    describe(name, function()
      ---@type any, LazySpecLoader
      local mod, spec

      it("spec is valid", function()
        mod = require(extra.modname)
        assert.is_not_nil(mod)
        spec = Plugin.Spec.new({
          { "williamboman/mason.nvim", opts = { ensure_installed = {} } },
          { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
          mod,
        }, { optional = true })
        assert(#spec.notifs == 0, "Invalid spec: " .. vim.inspect(spec.notifs))
      end)

      if extra.modname:find("%.lang%.") then
        it("has recommended set", function()
          assert(mod.recommended, "`recommended` not set for " .. extra.modname)
        end)
      end

      local lspconfig = spec.plugins["nvim-lspconfig"]
      if lspconfig then
        it("does not install LSP servers with mason.nvim", function()
          local lspconfig_opts = Plugin.values(lspconfig, "opts", false)
          local mason = spec.plugins["mason.nvim"]
          local mason_opts = Plugin.values(mason, "opts", false)

          for lsp in pairs(lspconfig_opts.servers or {}) do
            local lsp_pkg = lsp_to_pkg[lsp]
            assert(
              not (lsp_pkg and vim.tbl_contains(mason_opts.ensure_installed, lsp_pkg)),
              "LSP server "
                .. lsp
                .. " with pkg "
                .. (lsp_pkg or "foo")
                .. " is installed automatically. Please remove from the mason.nvim spec"
            )
          end
        end)
      end

      local ts = spec.plugins["nvim-treesitter"]
      local opts = Plugin.values(ts, "opts", false)

      if not vim.tbl_isempty(opts.ensure_installed) then
        it("does not install default Treesitter langs", function()
          local invalid = vim.tbl_filter(function(v)
            return vim.tbl_contains(tsensure, v)
          end, opts.ensure_installed or {})
          assert.same(
            {},
            invalid,
            "These Treesitter langs are installed by default. Please remove them from the extra."
          )
        end)
      end
    end)
  end
end)
