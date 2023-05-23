return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "go",
        "gomod",
        "gowork",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          semanticTokens = true,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason.nvim",
        opts = {
          ensure_installed = { "delve" },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    -- Add custom options for neotest-go in nvim-neotest opts.adapter_config["neotest-go"]
    opts = function(_, opts)
      opts.adapters = vim.list_extend(opts.adapters, { require("neotest-go") })
      opts.adapter_config = {
        ["neotest-go"] = {
          -- I.e. set opts.adapter_config["neotest-go"].args = { "-tags=integration" }
        },
      }
    end,
  },
}
