---@module 'luassert'

local Plugin = require("lazy.core.plugin")
_G.LazyVim = require("lazyvim.util")

local MODNAME = "lazyvim.plugins.extras.lang.kotlin"

---@param lsp? string value for vim.g.lazyvim_kotlin_lsp
local function servers(lsp)
  vim.g.lazyvim_kotlin_lsp = lsp
  package.loaded[MODNAME] = nil
  local spec = Plugin.Spec.new({ import = MODNAME }, { optional = true })
  vim.g.lazyvim_kotlin_lsp = nil
  package.loaded[MODNAME] = nil
  return Plugin.values(spec.plugins["nvim-lspconfig"], "opts", false).servers
end

describe("lang.kotlin", function()
  it("defaults to kotlin_language_server", function()
    local s = servers(nil)
    assert.is_true(s.kotlin_language_server.enabled)
    assert.is_false(s.kotlin_lsp.enabled)
  end)

  it("uses kotlin_lsp when selected", function()
    local s = servers("kotlin_lsp")
    assert.is_true(s.kotlin_lsp.enabled)
    assert.is_false(s.kotlin_language_server.enabled)
  end)

  it("uses kotlin_language_server when selected", function()
    local s = servers("kotlin_language_server")
    assert.is_true(s.kotlin_language_server.enabled)
    assert.is_false(s.kotlin_lsp.enabled)
  end)
end)
