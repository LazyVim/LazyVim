return {
  recommended = {
    ft = { "php", "blade" },
    root = { "artisan" },
  },

  { import = "lazyvim.plugins.extras.lang.php" },

  {
    "adalessa/laravel.nvim",
    optional = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
    },
    cmd = { "Laravel" },
    keys = {
      {
        "<localleader>ll",
        function()
          Laravel.pickers.laravel()
        end,
        desc = "Laravel: Open Laravel Picker",
      },
      {
        "<c-g>",
        function()
          Laravel.commands.run("view:finder")
        end,
        desc = "Laravel: Open View Finder",
      },
      {
        "<localleader>la",
        function()
          Laravel.pickers.artisan()
        end,
        desc = "Laravel: Open Artisan Picker",
      },
      {
        "<localleader>lt",
        function()
          Laravel.commands.run("actions")
        end,
        desc = "Laravel: Open Actions Picker",
      },
      {
        "<localleader>lr",
        function()
          Laravel.pickers.routes()
        end,
        desc = "Laravel: Open Routes Picker",
      },
      {
        "<localleader>lh",
        function()
          Laravel.run("artisan docs")
        end,
        desc = "Laravel: Open Documentation",
      },
      {
        "<localleader>lm",
        function()
          Laravel.pickers.make()
        end,
        desc = "Laravel: Open Make Picker",
      },
      {
        "<localleader>lc",
        function()
          Laravel.pickers.commands()
        end,
        desc = "Laravel: Open Commands Picker",
      },
      {
        "<localleader>lo",
        function()
          Laravel.pickers.resources()
        end,
        desc = "Laravel: Open Resources Picker",
      },
      {
        "<localleader>lp",
        function()
          Laravel.commands.run("command_center")
        end,
        desc = "Laravel: Open Command Center",
      },
      {
        "gf",
        function()
          local ok, res = pcall(function()
            if Laravel.app("gf").cursorOnResource() then
              return "<cmd>lua Laravel.commands.run('gf')<cr>"
            end
          end)
          if not ok or not res then
            return "gf"
          end
          return res
        end,
        expr = true,
        noremap = true,
      },
    },
    opts = {
      features = {
        pickers = {
          provider = "snacks", -- "snacks | telescope | fzf-lua | ui-select"
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "blade-formatter",
        "pint",
        "rustywind",
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "php-debug-adapter",
        args = {},
      }
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "phpdoc", "blade" } },
  },

  {
    "ricardoramirezr/blade-nav.nvim",
    optional = true,
    ft = { "blade", "php" },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "adalessa/laravel.nvim", "ricardoramirezr/blade-nav.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        compat = { "blade-nav", "laravel" },
        providers = {
          ["blade-nav"] = {
            name = "blade-nav",
            module = "blade-nav.blink",
          },
          laravel = {
            name = "laravel",
            module = "blink.compat.source",
            score_offset = 95,
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter", "rustywind" },
        php = { "php_cs_fixer", "pint" },
      },
    },
  },
}
