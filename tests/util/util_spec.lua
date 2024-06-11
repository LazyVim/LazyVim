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
end)
