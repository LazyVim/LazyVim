return {
  recommended = {
    ft = "blade",
    root = { "composer.json", "artisan" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "blade" } },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "tlint",
        "blade-formatter",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        blade = { "tlint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
      },
    },
  },
}
