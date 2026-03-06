return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "just",
      root = { "justfile", ".justfile" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "just" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        just = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        just = { "just" },
      },
    },
  },
}
