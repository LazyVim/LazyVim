---@class lazyvim.util.ui
local M = {}

-- foldtext for Neovim < 0.10.0
function M.foldtext()
  return vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1]
end

-- optimized treesitter foldexpr for Neovim >= 0.10.0
function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    -- as long as we don't have a filetype, don't bother
    -- checking if treesitter is available (it won't)
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    if vim.bo[buf].filetype:find("dashboard") then
      vim.b[buf].ts_folds = false
    else
      vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

---@return {fg?:string}?
function M.fg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) } or nil
end

function M.maximize()
  ---@type {k:string, v:any}[]?
  local maximized = nil
  local toggle = Snacks.toggle({
    name = "Maximize",
    get = function()
      return maximized ~= nil
    end,
    set = function(state)
      if state then
        maximized = {}
        local function set(k, v)
          table.insert(maximized, 1, { k = k, v = vim.o[k] })
          vim.o[k] = v
        end
        set("winwidth", 999)
        set("winheight", 999)
        set("winminwidth", 10)
        set("winminheight", 4)
        vim.cmd("wincmd =")
      else
        for _, opt in ipairs(maximized) do
          vim.o[opt.k] = opt.v
        end
        maximized = nil
        vim.cmd("wincmd =")
      end
    end,
  })

  -- `QuitPre` seems to be executed even if we quit a normal window, so we don't want that
  -- `VimLeavePre` might be another consideration? Not sure about differences between the 2
  vim.api.nvim_create_autocmd("ExitPre", {
    group = vim.api.nvim_create_augroup("lazyvim_restore_max_exit_pre", { clear = true }),
    desc = "Restore width/height when close Neovim while maximized",
    callback = function()
      if toggle:get() then
        toggle:set(false)
      end
    end,
  })
  return toggle
end

return M
