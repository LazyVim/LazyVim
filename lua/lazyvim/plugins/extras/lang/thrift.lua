return {
  recommended = {
    ft = "thrift",
    root = ".thrift",
  },
  {
    "nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "thrift" })
    end,
  },
  {
    "nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        thriftls = {},
      },
    },
  },
}
