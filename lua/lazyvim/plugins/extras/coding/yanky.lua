-- better yank/paste
local k = require("lazyvim.keymaps").get_keymaps()
return {
  "gbprod/yanky.nvim",
  recommended = true,
  desc = "Better Yank/Paste",
  event = "LazyFile",
  opts = {
    highlight = { timer = 150 },
  },
  keys = {
    {
      k.yanky_yank_history,
      function()
        if LazyVim.pick.picker.name == "telescope" then
          require("telescope").extensions.yank_history.yank_history({})
        else
          vim.cmd([[YankyRingHistory]])
        end
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
        -- stylua: ignore
    { k.yanky_yank, "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
    { k.yanky_put_text_after_cursor, "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
    { k.yanky_put_text_before_cursor, "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
    {
      k.yanky_put_text_after_selection,
      "<Plug>(YankyGPutAfter)",
      mode = { "n", "x" },
      desc = "Put Text After Selection",
    },
    {
      k.yanky_put_text_before_selection,
      "<Plug>(YankyGPutBefore)",
      mode = { "n", "x" },
      desc = "Put Text Before Selection",
    },
    { k.yanky_cycle_forward_yank_history, "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
    { k.yanky_cycle_backward_yank_history, "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
    {
      k.yanky_put_indent_after_cursor_linewise,
      "<Plug>(YankyPutIndentAfterLinewise)",
      desc = "Put Indented After Cursor (Linewise)",
    },
    {
      k.yanky_put_indent_before_cursor_linewise,
      "<Plug>(YankyPutIndentBeforeLinewise)",
      desc = "Put Indented Before Cursor (Linewise)",
    },
    {
      k.yanky_put_indent_after_cursor_linewise_alt,
      "<Plug>(YankyPutIndentAfterLinewise)",
      desc = "Put Indented After Cursor (Linewise)",
    },
    {
      k.yanky_put_indent_before_cursor_linewise_alt,
      "<Plug>(YankyPutIndentBeforeLinewise)",
      desc = "Put Indented Before Cursor (Linewise)",
    },
    { k.yanky_put_and_indent_right, "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
    { k.yanky_put_and_indent_left, "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
    { k.yanky_put_before_indent_right, "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
    { k.yanky_put_before_indent_left, "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
    { k.yanky_put_after_filter, "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
    { k.yanky_put_before_filter, "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
  },
}
