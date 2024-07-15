---@class lazyvim.util.toggle
local M = {}

---@class lazyvim.Toggle
---@field name string
---@field get fun():boolean
---@field set fun(state:boolean)
---@overload fun()
local T = {}
T.__index = T

---@param lhs string
---@param toggle lazyvim.Toggle
function M.map(lhs, toggle)
  LazyVim.safe_keymap_set("n", lhs, function()
    local state = not toggle.get()
    toggle.set(state)
    if state then
      LazyVim.info("Enabled " .. toggle.name, { title = toggle.name })
    else
      LazyVim.warn("Disabled " .. toggle.name, { title = toggle.name })
    end
  end, { desc = "Toggle" .. toggle.name })
  require("which-key").add({
    {
      lhs,
      icon = function()
        return toggle.get() and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
      end,
      desc = function()
        return (toggle.get() and "Disable " or "Enable ") .. toggle.name
      end,
    },
  })
end

---@type lazyvim.Toggle
M.treesitter = {
  name = "Treesitter Highlight",
  get = function()
    return vim.b.ts_highlight
  end,
  set = function(state)
    if state then
      vim.treesitter.start()
    else
      vim.treesitter.stop()
    end
  end,
}

---@param buf? boolean
function M.format(buf)
  ---@type lazyvim.Toggle
  local ret = {
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
  }
  return ret
end

---@param values? {[1]:any, [2]:any}
function M.option(option, values)
  ---@type lazyvim.Toggle
  local ret = {
    name = option,
    get = function()
      if values then
        return vim.opt_local[option]:get() == values[2]
      end
      return vim.opt_local[option]:get()
    end,
    set = function(state)
      if values then
        if state then
          vim.opt_local[option] = values[2]
        else
          vim.opt_local[option] = values[1]
        end
      else
        ---@diagnostic disable-next-line: no-unknown
        vim.opt_local[option] = state
      end
    end,
  }
  return ret
end

local nu = { number = true, relativenumber = true }
---@type lazyvim.Toggle
M.number = {
  name = "Line Numbers",
  get = function()
    return vim.opt_local.number:get() or vim.opt_local.relativenumber:get()
  end,
  set = function(state)
    if state then
      vim.opt_local.number = nu.number
      vim.opt_local.relativenumber = nu.relativenumber
    else
      nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end
  end,
}

local enabled = true
---@type lazyvim.Toggle
M.diagnostics = {
  name = "Diagnostics",
  get = function()
    if vim.diagnostic.is_enabled then
      enabled = vim.diagnostic.is_enabled()
    elseif vim.diagnostic.is_disabled then
      enabled = not vim.diagnostic.is_disabled()
    end
    return enabled
  end,
  set = vim.diagnostic.enable,
}

---@type lazyvim.Toggle
M.inlay_hints = {
  name = "Inlay Hints",
  get = function()
    return vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  end,
  set = function(state)
    vim.lsp.inlay_hint.enable(state, { bufnr = 0 })
  end,
}

---@type {k:string, v:any}[]
M._maximized = nil
---@type lazyvim.Toggle
M.maximize = {
  name = "Maximize",
  get = function()
    return M._maximized ~= nil
  end,
  set = function(state)
    if state then
      M._maximized = {}
      local function set(k, v)
        table.insert(M._maximized, 1, { k = k, v = vim.o[k] })
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
      for _, opt in ipairs(M._maximized) do
        vim.o[opt.k] = opt.v
      end
      M._maximized = nil
      vim.cmd("wincmd =")
    end
  end,
}

setmetatable(M, {
  __call = function(m, ...)
    return m.option(...)
  end,
})

return M
