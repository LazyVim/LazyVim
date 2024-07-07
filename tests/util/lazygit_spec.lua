---@module "luassert"

_G.LazyVim = require("lazyvim.util")

-- stylua: ignore
local git_remotes_cases = {
  ["https://github.com/LazyVim/LazyVim.git"]                             = "https://github.com/LazyVim/LazyVim",
  ["https://github.com/LazyVim/LazyVim"]                                 = "https://github.com/LazyVim/LazyVim",
  ["git@github.com:LazyVim/LazyVim"]                                     = "https://github.com/LazyVim/LazyVim",
  ["git@ssh.dev.azure.com:v3/neovim-org/owner/repo"]                     = "https://dev.azure.com/neovim-org/owner/_git/repo",
  ["https://folkelemaitre@bitbucket.org/samiulazim/neovim.git"]          = "https://bitbucket.org/samiulazim/neovim",
  ["git@bitbucket.org:samiulazim/neovim.git"]                            = "https://bitbucket.org/samiulazim/neovim",
  ["git@gitlab.com:inkscape/inkscape.git"]                               = "https://gitlab.com/inkscape/inkscape",
  ["https://gitlab.com/inkscape/inkscape.git"]                           = "https://gitlab.com/inkscape/inkscape",
  ["git@github.com:torvalds/linux.git"]                                  = "https://github.com/torvalds/linux",
  ["https://github.com/torvalds/linux.git"]                              = "https://github.com/torvalds/linux",
  ["git@bitbucket.org:team/repo.git"]                                    = "https://bitbucket.org/team/repo",
  ["https://bitbucket.org/team/repo.git"]                                = "https://bitbucket.org/team/repo",
  ["git@gitlab.com:example-group/example-project.git"]                   = "https://gitlab.com/example-group/example-project",
  ["https://gitlab.com/example-group/example-project.git"]               = "https://gitlab.com/example-group/example-project",
  ["git@ssh.dev.azure.com:v3/org/project/repo"]                          = "https://dev.azure.com/org/project/_git/repo",
  ["https://username@dev.azure.com/org/project/_git/repo"]               = "https://dev.azure.com/org/project/_git/repo",
  ["ssh://git@ghe.example.com:2222/org/repo.git"]                        = "https://ghe.example.com/org/repo",
  ["https://ghe.example.com/org/repo.git"]                               = "https://ghe.example.com/org/repo",
  ["git-codecommit.us-east-1.amazonaws.com/v1/repos/MyDemoRepo"]         = "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/MyDemoRepo",
  ["https://git-codecommit.us-east-1.amazonaws.com/v1/repos/MyDemoRepo"] = "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/MyDemoRepo",
  ["ssh://git@source.developers.google.com:2022/p/project/r/repo"]       = "https://source.developers.google.com/p/project/r/repo",
  ["https://source.developers.google.com/p/project/r/repo"]              = "https://source.developers.google.com/p/project/r/repo",
  ["git@git.sr.ht:~user/repo"]                                           = "https://git.sr.ht/~user/repo",
  ["https://git.sr.ht/~user/repo"]                                       = "https://git.sr.ht/~user/repo",
  ["git@git.sr.ht:~user/another-repo"]                                   = "https://git.sr.ht/~user/another-repo",
  ["https://git.sr.ht/~user/another-repo"]                               = "https://git.sr.ht/~user/another-repo",
}

describe("util.lazygit", function()
  for remote, expected in pairs(git_remotes_cases) do
    it("should parse git remote " .. remote, function()
      local url = LazyVim.lazygit.get_url(remote)
      assert.are.equal(expected, url)
    end)
  end
end)
