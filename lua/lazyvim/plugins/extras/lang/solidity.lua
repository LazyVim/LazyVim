return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "solidity",
      root = {
        "foundry.toml",
        "hardhat.config.js",
        "hardhat.config.ts",
      },
    })
  end,
  -- Add Solidity & related to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "solidity" } },
  },

  -- Correctly setup lspconfig for Solidity
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solidity_ls = {},
      },
    },
  },
  -- Formatter for Solidity
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        solidity = { "forge_fmt" },
      },
      formatters = {
        forge_fmt = {
          command = "forge",
          args = { "fmt" },
        },
      },
    },
  },
}
