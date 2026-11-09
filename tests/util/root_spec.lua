---@module "luassert"

_G.LazyVim = require("lazyvim.util")

describe("root", function()
  ---@param bufpath string
  ---@param root_dir string
  local function lsp_roots(bufpath, root_dir)
    local orig = { bufpath = LazyVim.root.bufpath, get_clients = vim.lsp.get_clients }
    LazyVim.root.bufpath = function()
      return bufpath
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.get_clients = function()
      return { { name = "test", config = {}, root_dir = root_dir } }
    end
    local ok, ret = pcall(LazyVim.root.detectors.lsp, 0)
    LazyVim.root.bufpath, vim.lsp.get_clients = orig.bufpath, orig.get_clients
    assert(ok, ret)
    return ret
  end

  it("lsp detector keeps a root that contains the buffer", function()
    assert.same({ "/src/repo" }, lsp_roots("/src/repo/lua/init.lua", "/src/repo"))
    assert.same({ "/src/repo" }, lsp_roots("/src/repo", "/src/repo"))
    assert.same({ "/" }, lsp_roots("/src/repo/init.lua", "/"))
  end)

  it("lsp detector ignores a sibling dir sharing a name prefix", function()
    assert.same({}, lsp_roots("/src/repo-worktree/lua/init.lua", "/src/repo"))
  end)
end)
