-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set
local k = require("lazyvim.keymaps").get_keymaps()

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", k.window_left, "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", k.window_lower, "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", k.window_upper, "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", k.window_right, "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", k.size_increase_height, "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", k.size_decrease_height, "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", k.size_decrease_width, "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", k.size_increase_width, "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", k.move_down, "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", k.move_up, "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", k.move_down, "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", k.move_up, "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", k.move_down, ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", k.move_up, ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", k.buf_prev, "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", k.buf_next, "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", k.buf_prev_alt, "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", k.buf_next_alt, "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", k.buf_switch_to_other, "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", k.buf_switch_to_other_alt, "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", k.buf_delete, LazyVim.ui.bufremove, { desc = "Delete Buffer" })
map("n", k.buf_delete_and_close, "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  k.clear_search_diff_update_and_redraw,
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, k.save_file, "<cmd>w<cr><esc>", { desc = "Save File" })

--keywordprg
map("n", k.keywordprg, "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", k.comment_add_below, "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", k.comment_add_above, "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", k.lazy, "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", k.new_file, "<cmd>enew<cr>", { desc = "New File" })

map("n", k.location_list, "<cmd>lopen<cr>", { desc = "Location List" })
map("n", k.quickfix_list, "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", k.previous_quickfix, vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", k.next_quickfix, vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting
map({ "n", "v" }, k.format, function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", k.diagnostic_line_diagnostics, vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", k.diagnostic_next_diagnostic, diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", k.diagnostic_prev_diagnostic, diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", k.diagnostic_next_error, diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", k.diagnostic_prev_error, diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", k.diagnostic_next_warning, diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", k.diagnostic_prev_warning, diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start

-- toggle options
LazyVim.toggle.map(k.toggle_auto_format_buffer, LazyVim.toggle.format())
LazyVim.toggle.map(k.toggle_auto_format_global, LazyVim.toggle.format(true))
LazyVim.toggle.map(k.toggle_spelling, LazyVim.toggle("spell", { name = "Spelling" }))
LazyVim.toggle.map(k.toggle_wrap, LazyVim.toggle("wrap", { name = "Wrap" }))
LazyVim.toggle.map(k.toggle_relativenumber, LazyVim.toggle("relativenumber", { name = "Relative Number" }))
LazyVim.toggle.map(k.toggle_diagnostics, LazyVim.toggle.diagnostics)
LazyVim.toggle.map(k.toggle_number, LazyVim.toggle.number)
LazyVim.toggle.map(k.toggle_conceallevel, LazyVim.toggle("conceallevel", { values = { 0, vim.o.conceallevel > 0 and vim.o.conceallevel or 2 } }))
LazyVim.toggle.map(k.toggle_treesitter, LazyVim.toggle.treesitter)
LazyVim.toggle.map(k.toggle_background, LazyVim.toggle("background", { values = { "light", "dark" }, name = "Background" }))
if vim.lsp.inlay_hint then
  LazyVim.toggle.map(k.toggle_inlay_hints, LazyVim.toggle.inlay_hints)
end

-- lazygit
map("n", k.lazygit_toggle_root, function() LazyVim.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
map("n", k.lazygit_toggle_cwd, function() LazyVim.lazygit() end, { desc = "Lazygit (cwd)" })
map("n", k.lazygit_blame_line, LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
map("n", k.lazygit_browse, LazyVim.lazygit.browse, { desc = "Git Browse" })

map("n", k.lazygit_current_file_history, function()
  local git_path = vim.api.nvim_buf_get_name(0)
  LazyVim.lazygit({args = { "-f", vim.trim(git_path) }})
end, { desc = "Lazygit Current File History" })

map("n", k.lazygit_git_log_root, function()
  LazyVim.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
end, { desc = "Lazygit Log" })
map("n", k.lazygit_git_log_cwd, function()
  LazyVim.lazygit({ args = { "log" } })
end, { desc = "Lazygit Log (cwd)" })

-- quit
map("n", k.quit_all, "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", k.inspect_pos, vim.show_pos, { desc = "Inspect Pos" })
map("n", k.inspect_tree, "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- LazyVim Changelog
map("n", k.lazyvim_changelog, function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
map("n", k.terminal_toggle_root, lazyterm, { desc = "Terminal (Root Dir)" })
map("n", k.terminal_toggle_cwd, function() LazyVim.terminal() end, { desc = "Terminal (cwd)" })
map("n", k.terminal_toggle_root_alt_1, lazyterm, { desc = "Terminal (Root Dir)" })
map("n", k.terminal_toggle_root_alt_2, lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", k.terminal_enter_normal_mode, "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", k.window_left, "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", k.window_lower, "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", k.window_upper, "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", k.window_right, "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", k.terminal_hide_terminal, "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", k.terminal_hide_terminal_alt, "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", k.window_prefix, "<c-w>", { desc = "Windows", remap = true })
map("n", k.window_split_window_below, "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", k.window_split_window_right, "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", k.window_delete_window, "<C-W>c", { desc = "Delete Window", remap = true })
LazyVim.toggle.map(k.window_toggle_maximize_window, LazyVim.toggle.maximize)

-- tabs
map("n", k.tab_last_tab, "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", k.tab_close_other_tabs, "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", k.tab_first_tab, "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", k.tab_new_tab, "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", k.tab_new_tab, "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", k.tab_close_other_tabs, "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", k.tab_previous_tab, "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
