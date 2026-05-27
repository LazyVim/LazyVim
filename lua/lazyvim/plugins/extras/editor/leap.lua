-- A helper function making it easier to set "clever-f" behavior
-- (use f/F or t/T instead of ;/, - see the plugin clever-f.vim).
local function clever(...)
  return require("leap.user").with_traversal_keys(...)
end

local function ft(key_specific_args)
  require("leap").leap(vim.tbl_deep_extend("keep", key_specific_args, {
    inputlen = 1,
    inclusive = true,
    opts = {
      labels = "",
      safe_labels = vim.fn.mode(true):match("no?") and "" or nil,
    },
  }))
end

return {
  -- disable flash
  { "folke/flash.nvim", enabled = false, optional = true },

  -- Leap provides improved vim-sneak-style navigation with live label
  -- preview and multi-window scope, and also extra features like remote
  -- operations and incremental treesitter node selection.
  {
    url = "https://codeberg.org/andyg/leap.nvim.git",
    keys = {
      { "s", mode = { "n", "x", "o" }, "<Plug>(leap)", desc = "Leap" },
      { "S", mode = { "n" }, "<Plug>(leap-from-window)", desc = "Leap from Window" },
      -- Enhanced f/t motions.
      -- To keep using `;`/`,` just set `opts = clever(";", ",")` everywhere.
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          ft({ opts = clever("f", "F") })
        end,
      },
      {
        "F",
        mode = { "n", "x", "o" },
        function()
          ft({ backward = true, opts = clever("f", "F") })
        end,
      },
      {
        "t",
        mode = { "n", "x", "o" },
        function()
          ft({ offset = -1, opts = clever("t", "T") })
        end,
      },
      {
        "T",
        mode = { "n", "x", "o" },
        function()
          ft({ backward = true, offset = 1, opts = clever("t", "T") })
        end,
      },
      -- See the documentation for extras, like setting up automatic
      -- pasting after yank operations or defining remote text objects.
      {
        "gs",
        mode = { "n", "o" },
        function()
          -- Automatically enter Visual mode when coming from Normal.
          require("leap.remote").action({ input = vim.fn.mode(true):match("o") and "" or "v" })
        end,
        desc = "Remote Operation",
      },
      {
        "R",
        mode = { "x", "o" },
        function()
          require("leap.treesitter").select({ opts = clever("R", "r") })
        end,
        desc = "Leap Treesitter",
      },
    },
    opts = {
      -- Exclude whitespace and the middle of alphabetic words from preview.
      preview = function(ch0, ch1, ch2)
        return not (ch1:match("%s") or ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
      end,
      equivalence_classes = { " \t\n\r", "[({", "})]", "\"'`" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
    end,
  },

  -- rename surround mappings from gs to gz to prevent conflict with leap
  {
    "nvim-mini/mini.surround",
    optional = true,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
    keys = {
      { "gz", "", desc = "+surround" },
    },
  },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },
}
