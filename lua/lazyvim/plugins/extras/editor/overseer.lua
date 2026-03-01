return {
  {
    "catppuccin",
    optional = true,
    opts = {
      integrations = { overseer = true },
    },
  },
  {
    "stevearc/overseer.nvim",
    lazy = false, -- plugin is self-lazy-loading
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerRun",
      "OverseerTaskAction",
    },
    opts = {
      dap = false,
      task_list = {
        keymaps = {
          ["<C-j>"] = false,
          ["<C-k>"] = false,
        },
      },
      form = {
        win_opts = {
          winblend = 0,
        },
      },
      task_win = {
        win_opts = {
          winblend = 0,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle!<cr>",    desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>",        desc = "Run task" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>o", group = "overseer" },
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "Overseer",
        ft = "OverseerList",
        open = function()
          require("overseer").open()
        end,
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      opts = opts or {}
      opts.consumers = opts.consumers or {}
      opts.consumers.overseer = require("neotest.consumers.overseer")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      require("overseer").enable_dap()
    end,
  },
}
