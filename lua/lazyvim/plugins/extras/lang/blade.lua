return {
  recommended = {
    ft = "blade",
    root = { "composer.json", "artisan" },
  },
  {
    "nvim-tressiter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "blade", "php" })
      end

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.blade.php" },
        callback = function()
          vim.treesitter.start(nil, "blade")
          vim.opt.filetype = "blade"
        end,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "tlint",
        "blade-formatter",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        blade = { "tlint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
      },
    },
  },
}
