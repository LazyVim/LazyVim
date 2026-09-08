local rojo_project

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "luau",
      root = {
        ".luaurc",
        ".config.luau",
        "*.project.json",
      },
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "luau" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        luau_lsp = {},
      },
      setup = {
        luau_lsp = function(_, config)
          -- luau-lsp.nvim configures it's own lsp so forward the config to it
          vim.lsp.config("luau-lsp", config)
          return true
        end,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        luau = { "stylua" },
      },
    },
  },

  {
    "lopi-py/luau-lsp.nvim",
    ft = "luau",
    init = function()
      rojo_project = vim.fs.root(0, function(name)
        return name:match(".+%.project%.json$")
      end)

      if rojo_project then
        vim.filetype.add({
          extension = {
            lua = function(path)
              return path:match("%.nvim%.lua$") and "lua" or "luau"
            end,
          },
        })
      end
    end,
    opts = function()
      return {
        platform = {
          type = rojo_project and "roblox" or "standard",
        },
      }
    end,
  },
}
