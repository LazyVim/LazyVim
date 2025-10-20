---@module 'luassert'
---@module 'lazy'

local Icons = require("mini.icons")

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

  require("mason").setup()
  local mr = require("mason-registry")
  mr.refresh()

  local lsp_to_pkg = {}
  lsp_to_pkg = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
  it("can get lspconfig to package map", function()
    assert(not vim.tbl_isempty(lsp_to_pkg), "Could not get lspconfig to package map")
  end)

  local tsspec = Plugin.Spec.new({
    import = "lazyvim.plugins.treesitter",
  }, { optional = true })

  local tsopts = Plugin.values(tsspec.plugins["nvim-treesitter"], "opts", false)

  local tsensure = tsopts.ensure_installed
  assert(type(tsensure) == "table", "No ensure_installed in nvim-treesitter spec")

  for _, extra in ipairs(extras) do
    local name = extra.modname:sub(#"lazyvim.plugins.extras" + 2)
    describe(name, function()
      it("spec is valid", function()
        local mod = require(extra.modname)
        assert.is_not_nil(mod)
        local spec = Plugin.Spec.new({
          { "mason-org/mason.nvim", opts = { ensure_installed = {} } },
          { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
          mod,
        }, { optional = true })
        assert(#spec.notifs == 0, "Invalid spec: " .. vim.inspect(spec.notifs))
      end)

      if extra.modname:find("%.lang%.") then
        it("has recommended set", function()
          local mod = require(extra.modname)
          assert(mod.recommended, "`recommended` not set for " .. extra.modname)
        end)
      end

      local mod = require(extra.modname)
      local spec = Plugin.Spec.new({
        { "mason-org/mason.nvim", opts = { ensure_installed = {} } },
        { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
        mod,
      }, { optional = true })

      it("it has no renamed plugins", function()
        for _, p in pairs(spec.plugins) do
          local short_url = p[1]
          assert(
            not LazyVim.plugin.renames[short_url],
            "Plugin " .. short_url .. " has been renamed to " .. (LazyVim.plugin.renames[short_url] or "")
          )
        end
      end)

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

      -- Icons
      local icons = spec.plugins["mini.icons"]
      if icons then
        local icon_opts = Plugin.values(icons, "opts", false) or {}
        local cats = { "directory", "file", "extension", "filetype", "lsp", "os" }
        for _, cat in ipairs(cats) do
          local cat_names = Icons.list(cat)
          if icon_opts[cat] then
            describe("does not set existing icons for " .. cat, function()
              for icon_name in pairs(icon_opts[cat]) do
                it(icon_name, function()
                  assert.is_false(
                    vim.tbl_contains(cat_names, icon_name),
                    "Icon " .. icon_name .. " already exists:\n" .. vim.inspect({ Icons.get(cat, icon_name) })
                  )
                end)
              end
            end)
          end
        end
      end
    end)
  end
end)
