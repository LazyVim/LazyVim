local k = require("lazyvim.keymaps").get_keymaps()
local default = require("lazyvim.keymaps").default_keymaps

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
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { k.leap_next, mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { k.leap_prev, mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      { k.leap_from_windows, mode = { "n", "x", "o" }, desc = "Leap from Windows" },
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
        add = k.minisurround_add == default.minisurround_add and "gza" or k.minisurround_add, -- Add surrounding in Normal and Visual modes
        delete = k.minisurround_delete == default.minisurround_delete and "gzd" or k.minisurround_delete, -- Delete surrounding
        find = k.minisurround_find == default.minisurround_find and "gzf" or k.minisurround_find, -- Find surrounding (to the right)
        find_left = k.minisurround_find_left == default.minisurround_find_left and "gzF" or k.minisurround_find_left, -- Find surrounding (to the left)
        highlight = k.minisurround_highlight == default.minisurround_highlight and "gzh" or k.minisurround_highlight, -- Highlight surrounding
        replace = k.minisurround_replace == default.minisurround_replace and "gzr" or k.minisurround_replace, -- Replace surrounding
        update_n_lines = k.minisurround_update_n_lines == default.minisurround_update_n_lines and "gzn"
          or k.minisurround_update_n_lines, -- Update `n_lines`
      },
    },
    keys = {
      {
        k.minisurround_prefix == default.minisurround_prefix and "gz" or k.minisurround_prefix,
        "",
        desc = "+surround",
      },
    },
  },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },
}
