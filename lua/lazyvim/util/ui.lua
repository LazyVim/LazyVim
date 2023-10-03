local M = {}

---@alias Sign {name:string, text:string, texthl:string}

---@return Sign[]
function M.get_signs(win)
  local buf = vim.api.nvim_win_get_buf(win)
  ---@diagnostic disable-next-line: no-unknown
  return vim.tbl_map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
end

---@param sign? Sign
---@param len? number
function M.icon(sign, len)
  sign = sign or {}
  len = len or 2
  local text = vim.fn.strcharpart(sign.text or "", 0, len) ---@type string
  text = text .. string.rep(" ", len - vim.fn.strchars(text))
  return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

function M.foldtext()
  local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()
  if not ret then
    ret = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
  end
  table.insert(ret, { " " .. require("lazyvim.config").icons.misc.dots })

  if not vim.treesitter.foldtext then
    return table.concat(
      vim.tbl_map(function(line)
        return line[1]
      end, ret),
      " "
    )
  end
  return ret
end

function M.statuscolumn()
  local win = vim.g.statusline_winid
  if vim.wo[win].signcolumn == "no" then
    return ""
  end

  ---@type Sign?,Sign?,Sign?
  local left, right, fold
  for _, s in ipairs(M.get_signs(win)) do
    if s.name:find("GitSign") then
      right = s
    elseif not left then
      left = s
    end
  end

  vim.api.nvim_win_call(win, function()
    if vim.fn.foldclosed(vim.v.lnum) >= 0 then
      fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
    end
  end)

  local nu = ""
  if vim.wo[win].number and vim.v.virtnum == 0 then
    nu = vim.wo[win].relativenumber and vim.v.relnum ~= 0 and vim.v.relnum or vim.v.lnum
  end

  return table.concat({
    M.icon(left),
    [[%=]],
    nu .. " ",
    M.icon(fold or right),
  }, "")
end

return M
