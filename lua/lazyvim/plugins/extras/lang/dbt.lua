return {
  recommended = {
    root = "dbt_project.yml",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "sql" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dbt = {
          keys = {
            { "<localleader>c", "<cmd>LspDbtCompile<cr>", desc = "Compiled SQL" },
          },
        },
      },
    },
  },
}
