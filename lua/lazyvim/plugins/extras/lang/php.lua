return {
  recommended = {
    ft = "php",
    root = { "composer.json", ".phpactor.json", ".phpactor.yml" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "php" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        phpactor = {},
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          table.insert(opts.ensure_installed, "php-debug-adapter")
        end
      end,
    },
    opts = function()
      local dap = require("dap")
      local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { path .. "/extension/out/phpDebug.js" },
      }
    end,
  },
}
