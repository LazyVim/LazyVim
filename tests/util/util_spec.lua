---@module "luassert"

local LazyVim = require("lazyvim.util")

describe("util", function()
  local t = 0
  local fn = function(a)
    t = t + 1
    return a
  end

  local m = LazyVim.memoize(fn)

  it("should memoize a function", function()
    local a = m(1)
    local b = m(1)
    local c = m(2)
    assert.are.equal(a, b)
    assert.are.equal(a, 1)
    assert.are.equal(c, 2)
    assert.are.equal(t, 2)
    assert.are_not.equal(a, c)
  end)

  local f1 = LazyVim.memoize(function()
    return 1
  end)
  local f2 = LazyVim.memoize(function()
    return 2
  end)

  it("should memoize based on the correct key", function()
    assert.are.equal(f1(), 1)
    assert.are.equal(f2(), 2)
  end)

  describe("get_pkg_path", function()
    local package_path
    local mason

    before_each(function()
      package_path = LazyVim.config.package_path
      mason = vim.env.MASON
    end)

    after_each(function()
      LazyVim.config.package_path = package_path
      vim.env.MASON = mason
    end)

    it("should resolve packages with a custom provider", function()
      LazyVim.config.package_path = function(pkg, path)
        return "/packages/" .. pkg .. path
      end

      local path = LazyVim.get_pkg_path("svelte-language-server", "/node_modules/typescript-svelte-plugin", {
        warn = false,
      })
      assert.are.equal("/packages/svelte-language-server/node_modules/typescript-svelte-plugin", path)
    end)

    it("should fall back to Mason when the provider returns nil", function()
      LazyVim.config.package_path = function()
        return nil
      end
      vim.env.MASON = "/mason"

      local path = LazyVim.get_pkg_path("svelte-language-server", "/node_modules/typescript-svelte-plugin", {
        warn = false,
      })
      assert.are.equal("/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin", path)
    end)
  end)
end)
