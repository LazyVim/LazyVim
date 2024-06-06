return {
  recommended = {
    ft = { "gitcommit", "gitconfig", "gitrebase", "gitignore", "gitattributes" },
  },
  -- Treesitter git support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "git_config", "gitcommit", "git_rebase", "gitignore", "gitattributes" })
    end,
  },

  {
    "nvim-cmp",
    dependencies = {
      {
        "petertriho/cmp-git",
        opts = {},
      },
    },
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "git" })
    end,
  },
}
