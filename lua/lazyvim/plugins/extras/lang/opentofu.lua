vim.filetype.add({
  extension = {
    tofu = "opentofu",
  },
})

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "hcl",
      root = ".tofu",
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "terraform", "hcl" })
      vim.treesitter.language.register("opentofu", "hcl")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tofu_ls = {},
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.opentofu_fmt,
        null_ls.builtins.diagnostics.opentofu_validate,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        opentofu = { "tofu" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        opentofu = { "tofu_fmt" },
      },
    },
  },
}
