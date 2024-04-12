return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "groovy" })
      vim.filetype.add({
        pattern = {
          [".*.Jenkinsfile"] = "groovy",
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "npm-groovy-lint" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        groovyls = {},
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        groovy = { "npm-groovy-lint" },
      },
      linters = {
        ["npm-groovy-lint"] = {
          args = { "--failon", "error" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        groovy = { "npm_groovy_lint" },
      },
      formatters = {
        npm_groovy_lint = {
          command = "npm-groovy-lint",
          args = { "--failon", "error", "--format", "$FILENAME" },
          cwd = require("conform.util").root_file({ ".git" }),
          stdin = false,
        },
      },
    },
  },
}
