return {
  -- Add linting, debug adapter, language server
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "ktlint", "kotlin-language-server", "kotlin-debug-adapter" },
    },
  },
  -- Add syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "kotlin" },
    },
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
