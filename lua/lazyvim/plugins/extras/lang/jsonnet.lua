return {
  { "google/vim-jsonnet" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        jsonnet_ls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "jsonnet" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "jsonnet-language-server",
      })
    end,
  },
}
