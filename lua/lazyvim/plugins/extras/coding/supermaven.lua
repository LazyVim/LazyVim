return {
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_suggestion = "<C-y>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "supermaven",
        group_index = 1,
        priority = 100,
      })
    end,
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
