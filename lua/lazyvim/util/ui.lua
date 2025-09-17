---@class lazyvim.util.ui
local M = {}

M.installed = {} ---@type string[]

---@param ft string
function M.have(ft)
  local lang = vim.treesitter.language.get_lang(ft)
  return vim.tbl_contains(M.installed, lang)
end

function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  return M.have(vim.b[buf].filetype) and vim.treesitter.foldexpr() or "0"
end

function M.indentexpr()
  local buf = vim.api.nvim_get_current_buf()
  return M.have(vim.b[buf].filetype) and require("nvim-treesitter").indentexpr() or -1
end

return M
