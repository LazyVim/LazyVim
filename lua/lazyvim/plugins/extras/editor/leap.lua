local k = require("lazyvim.keymaps").get_keymaps().extras.editor.leap
local m = require("lazyvim.keymaps").get_keymaps().extras.coding.mini_surround
local default = require("lazyvim.keymaps").default_keymaps.extras.coding.mini_surround

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
      { k.next, mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { k.prev, mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      { k.from_windows, mode = { "n", "x", "o" }, desc = "Leap from Windows" },
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
        add = m.add == default.add and "gza" or m.add, -- Add surrounding in Normal and Visual modes
        delete = m.delete == default.delete and "gzd" or m.delete, -- Delete surrounding
        find = m.find == default.find and "gzf" or m.find, -- Find surrounding (to the right)
        find_left = m.find_left == default.find_left and "gzF" or m.find_left, -- Find surrounding (to the left)
        highlight = m.highlight == default.highlight and "gzh" or m.highlight, -- Highlight surrounding
        replace = m.replace == default.replace and "gzr" or m.replace, -- Replace surrounding
        update_n_lines = m.update_n_lines == default.update_n_lines and "gzn" or m.update_n_lines, -- Update `n_lines`
      },
    },
    keys = {
      { m.prefix == default.prefix and "gz" or m.prefix, "", desc = "+surround" },
    },
  },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },
}
