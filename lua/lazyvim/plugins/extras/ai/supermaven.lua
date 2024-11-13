return {
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
      },
      disable_inline_completion = vim.g.ai_cmp,
    },
  },

  -- add ai_accept action
  {
    "supermaven-inc/supermaven-nvim",
    opts = function()
      require("supermaven-nvim.completion_preview").suggestion_group = "SupermavenSuggestion"
      LazyVim.cmp.actions.ai_accept = function()
        local suggestion = require("supermaven-nvim.completion_preview")
        if suggestion.has_suggestion() then
          LazyVim.create_undo()
          vim.schedule(function()
            suggestion.on_accept_suggestion()
          end)
          return true
        end
      end
    end,
  },

  -- cmp integration
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "supermaven-nvim" },
    opts = function(_, opts)
      if vim.g.ai_cmp then
        table.insert(opts.sources, 1, {
          name = "supermaven",
          group_index = 1,
          priority = 100,
        })
      end
    end,
  },

  -- blink.cmp integration
  --
  -- FIXME: this currently doesn't work properly
  -- {
  --   "saghen/blink.cmp",
  --   optional = true,
  --   opts = {
  --     sources = {
  --       compat = vim.g.ai_cmp and { "supermaven" } or nil,
  --     },
  --   },
  --   dependencies = {
  --     "supermaven-nvim",
  --     vim.g.ai_cmp and "saghen/blink.compat" or nil,
  --   },
  -- },
  --
  -- Disabble cmp integration for now
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      windows = { ghost_text = { enabled = false } },
    },
    dependencies = {
      {
        "supermaven-nvim",
        opts = {
          disable_inline_completion = false,
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source("supermaven"))
    end,
  },

  {
    "folke/noice.nvim",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.routes, {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "Starting Supermaven" },
              { find = "Supermaven Free Tier" },
            },
          },
          skip = true,
        },
      })
    end,
  },
}
