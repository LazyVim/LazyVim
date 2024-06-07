return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "sh",
    })
  end,

  -- LSP
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "bash-language-server",
          "shellcheck",
          "shfmt",
        })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
  },

  -- Treesitter for bash is installed by default.
  -- Linter(shellchecker) and formatter(shfmt) can be triggered by bashls.
}
