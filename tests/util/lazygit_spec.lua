---@module "luassert"

local LazyVim = require("lazyvim.util")

local git_remotes_cases = {
  ["https://github.com/lazyvim/lazyvim.git"] = {
    scheme = "https",
    host = "github.com",
    owner = "lazyvim",
    repo = "lazyvim.git",
  },
  ["git@github.com/lazyvim/lazyvim"] = {
    scheme = "ssh",
    host = "github.com",
    owner = "lazyvim",
    repo = "lazyvim",
  },
  ["git@ssh.dev.azure.com:v3/neovim-org/owner/repo"] = {
    scheme = "ssh",
    host = "ssh.dev.azure.com",
    owner = "neovim-org/owner",
    repo = "repo",
  },
}

describe("util.lazygit", function()
  it("should parse git remotes", function()
    for url, expected_remote in pairs(git_remotes_cases) do
      local remote = LazyVim.lazygit.parse_remote_url(url)
      assert.are.equal(expected_remote, remote)
    end
  end)
end)
