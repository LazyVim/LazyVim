return {
  -- disable flash
  { "folke/flash.nvim", enabled = false, optional = true },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/flit.nvim",
    enabled = true,
    keys = function()
      ---@type LazyKeysSpec[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
      end
      return ret
    end,
    opts = { labeled_modes = "nxo" },
  },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  -- rename surround mappings from gs to gz to prevent conflict with leap
  {
    "echasnovski/mini.surround",
    optional = true,
    opts = {
      mappings = {
        add = "gaa", -- Add surrounding in Normal and Visual modes
        delete = "gad", -- Delete surrounding
        find = "gaf", -- Find surrounding (to the right)
        find_left = "gaF", -- Find surrounding (to the left)
        highlight = "gah", -- Highlight surrounding
        replace = "gar", -- Replace surrounding
        update_n_lines = "gan", -- Update `n_lines`
      },
    },
    keys = {
      { "ga", "", desc = "+surround" },
    },
  },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },
}
