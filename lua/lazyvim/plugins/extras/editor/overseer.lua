local k = require("lazyvim.keymaps").get_keymaps()

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
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    opts = {
      dap = false,
      task_list = {
        bindings = {
          ["<C-h>"] = false,
          ["<C-j>"] = false,
          ["<C-k>"] = false,
          ["<C-l>"] = false,
        },
      },
      form = {
        win_opts = {
          winblend = 0,
        },
      },
      confirm = {
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
      { k.overseer_toggle, "<cmd>OverseerToggle<cr>",      desc = "Task list" },
      { k.overseer_run, "<cmd>OverseerRun<cr>",         desc = "Run task" },
      { k.overseer_quick_action, "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { k.overseer_info, "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
      { k.overseer_build, "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
      { k.overseer_task_action, "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
      { k.overseer_clear_cache, "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        k.overseer_prefix == "" and {} or { k.overseer_prefix, group = "overseer" },
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
