---@class lazyvim.util.toggle
local M = {}

---@param buf? boolean
function M.format(buf)
  return Snacks.toggle({
    name = "Auto Format (" .. (buf and "Buffer" or "Global") .. ")",
    get = function()
      if not buf then
        return vim.g.autoformat == nil or vim.g.autoformat
      end
      return LazyVim.format.enabled()
    end,
    set = function(state)
      LazyVim.format.enable(state, buf)
    end,
  })
end

function M.maximize()
  ---@type {k:string, v:any}[]?
  local maximized = nil
  return Snacks.toggle({
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
        -- `QuitPre` seems to be executed even if we quit a normal window, so we don't want that
        -- `VimLeavePre` might be another consideration? Not sure about differences between the 2
        vim.api.nvim_create_autocmd("ExitPre", {
          once = true,
          group = vim.api.nvim_create_augroup("lazyvim_restore_max_exit_pre", { clear = true }),
          desc = "Restore width/height when close Neovim while maximized",
          callback = function()
            M.maximize.set(false)
          end,
        })
      else
        for _, opt in ipairs(maximized) do
          vim.o[opt.k] = opt.v
        end
        maximized = nil
        vim.cmd("wincmd =")
      end
    end,
  })
end

return M
