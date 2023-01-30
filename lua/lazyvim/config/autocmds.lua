-- This file is automatically loaded by plugins.init

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("_lazy_vim_highlight_on_yank", { clear = true }),
})

-- resize splits if window got resized
vim.api.nvim_create_augroup("_lazy_vim_resize_splits", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  group = "_lazy_vim_resize_splits",
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  group = vim.api.nvim_create_augroup("_lazy_vim_go_to_last_loc_when_opening_a_buffer", { clear = true }),
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  group = vim.api.nvim_create_augroup("_lazy_vim_close_some_filetypes_with_q", { clear = true }),
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  group = vim.api.nvim_create_augroup("_lazy_vim_wrap_and_spell_check_text_filetypes", { clear = true }),
})
