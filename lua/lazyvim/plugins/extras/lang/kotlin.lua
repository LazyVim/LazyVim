return {
  -- Add linting, debug adapter, language server
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "ktlint",
        "kotlin-language-server",
        "kotlin-debug-adapter",
      })
    end,
  },
  -- Add syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "kotlin" })
    end,
  },
  -- Add language server
  {
    "neovim/nvim-lspconfig",
    dependencies = "williamboman/mason.nvim",
    opts = {
      servers = {
        kotlin_language_server = {},
      },
    },
  },
  -- Add linting
  {
    "mfussenegger/nvim-lint",
    dependencies = "williamboman/mason.nvim",
    opts = {
      linters_by_ft = { kotlin = { "ktlint" } },
    },
  },
  -- Add formatting
  {
    "stevearc/conform.nvim",
    dependencies = "williamboman/mason.nvim",
    opts = {
      formatters_by_ft = { kotlin = { "ktlint" } },
    },
  },
  -- Add debugger
  {
    "mfussenegger/nvim-dap",
    dependencies = "williamboman/mason.nvim",
  },
}
