---@meta

---@class LazyVimGlobals
vim.g = {}

_G.lazyvim_docs = true
_G.LazyVim = require("lazyvim.util")

---@class vim.api.create_autocmd.callback.args
---@field id number
---@field event string
---@field group number?
---@field match string
---@field buf number
---@field file string
---@field data any

---@class vim.api.keyset.create_autocmd.opts: vim.api.keyset.create_autocmd
---@field callback? fun(ev:vim.api.create_autocmd.callback.args):boolean?

--- @param event any (string|array) Event(s) that will trigger the handler
--- @param opts vim.api.keyset.create_autocmd.opts
--- @return integer
function vim.api.nvim_create_autocmd(event, opts) end
