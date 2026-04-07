return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "moonbit", "mbt" },
      root = { "moon.mod.json" },
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "moonbit" } },
  },

  -- TODO: Enable once moonbit LSP is available in mason registry
  -- https://github.com/mason-org/mason-registry
  -- {
  --   "mason-org/mason.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, { "moonbit-lsp" })
  --   end,
  -- },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        moonbit = {
          cmd = { "moonbit-lsp" },
          filetypes = { "moonbit", "mbt" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("moon.mod.json")(fname)
          end,
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        moonbit = { "moonfmt" },
      },
    },
  },
}
