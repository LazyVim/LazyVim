---@class lazyvim.util.treesitter
local M = {}

M._installed = nil ---@type table<string,string>?

---@param force boolean?
function M.get_installed(force)
  if not M._installed or force then
    M._installed = {}
    for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
      M._installed[lang] = lang
    end
  end
  return M._installed
end

---@param ft string
function M.have(ft)
  local lang = vim.treesitter.language.get_lang(ft)
  return lang and M.get_installed()[lang]
end

function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  return M.have(vim.bo[buf].filetype) and vim.treesitter.foldexpr() or "0"
end

function M.indentexpr()
  local buf = vim.api.nvim_get_current_buf()
  return M.have(vim.bo[buf].filetype) and require("nvim-treesitter").indentexpr() or -1
end

return M
