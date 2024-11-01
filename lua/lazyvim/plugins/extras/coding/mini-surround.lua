-- Fast and feature-rich surround actions. For text that includes
-- surrounding characters like brackets or quotes, this allows you
-- to select the text inside, change or modify the surrounding characters,
-- and more.
local k = require("lazyvim.keymaps").get_keymaps()

return {
  "echasnovski/mini.surround",
  recommended = true,
  keys = function(_, keys)
    -- Populate the keys based on the user's options
    local opts = LazyVim.opts("mini.surround")
    local mappings = {
      { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
      { opts.mappings.delete, desc = "Delete Surrounding" },
      { opts.mappings.find, desc = "Find Right Surrounding" },
      { opts.mappings.find_left, desc = "Find Left Surrounding" },
      { opts.mappings.highlight, desc = "Highlight Surrounding" },
      { opts.mappings.replace, desc = "Replace Surrounding" },
      { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    mappings = {
      add = k.minisurround_add, -- Add surrounding in Normal and Visual modes
      delete = k.minisurround_delete, -- Delete surrounding
      find = k.minisurround_find, -- Find surrounding (to the right)
      find_left = k.minisurround_find_left, -- Find surrounding (to the left)
      highlight = k.minisurround_highlight, -- Highlight surrounding
      replace = k.minisurround_replace, -- Replace surrounding
      update_n_lines = k.minisurround_update_n_lines, -- Update `n_lines`
    },
  },
}
