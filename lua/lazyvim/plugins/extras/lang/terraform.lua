vim.api.nvim_create_autocmd("FileType", {
  pattern = { "hcl", "terraform" },
  desc = "terraform/hcl commentstring configuration",
  command = "setlocal commentstring=#\\ %s",
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "terraform",
          "hcl",
        })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {},
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.diagnostics.terraform_validate,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft.terraform = opts.linters_by_ft.terraform or {}
      table.insert(opts.linters_by_ft.terraform, "terraform_validate")

      opts.linters_by_ft.tf = opts.linters_by_ft.tf or {}
      table.insert(opts.linters_by_ft.tf, "terraform_validate")
      return opts
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft.terraform = opts.formatters_by_ft.terraform or {}
      table.insert(opts.formatters_by_ft.terraform, "terraform_fmt")

      opts.formatters_by_ft.tf = opts.formatters_by_ft.tf or {}
      table.insert(opts.formatters_by_ft.tf, "terraform_fmt")

      opts.formatters_by_ft["terraform-vars"] = opts.formatters_by_ft["terraform-vars"] or {}
      table.insert(opts.formatters_by_ft["terraform-vars"], "terraform_fmt")
      return opts
    end,
  },
}
