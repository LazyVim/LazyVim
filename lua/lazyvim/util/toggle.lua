---@class lazyvim.util.toggle
local M = {}

---@class lazyvim.Toggle
---@field name string
---@field get fun():boolean
---@field set fun(state:boolean)

---@class lazyvim.Toggle.wrap: lazyvim.Toggle
---@operator call:boolean

---@param toggle lazyvim.Toggle
function M.wrap(toggle)
  return setmetatable(toggle, {
    __call = function()
      toggle.set(not toggle.get())
      local state = toggle.get()
      if state then
        LazyVim.info("Enabled " .. toggle.name, { title = toggle.name })
      else
        LazyVim.warn("Disabled " .. toggle.name, { title = toggle.name })
      end
      return state
    end,
  }) --[[@as lazyvim.Toggle.wrap]]
end

---@param lhs string
---@param toggle lazyvim.Toggle
function M.map(lhs, toggle)
  local t = M.wrap(toggle)
  LazyVim.safe_keymap_set("n", lhs, function()
    t()
  end, { desc = "Toggle " .. toggle.name })
  M.wk(lhs, toggle)
end

function M.wk(lhs, toggle)
  if not LazyVim.has("which-key.nvim") then
    return
  end
  local function safe_get()
    local ok, enabled = pcall(toggle.get)
    if not ok then
      LazyVim.error({ "Failed to get toggle state for **" .. toggle.name .. "**:\n", enabled }, { once = true })
    end
    return enabled
  end
  require("which-key").add({
    {
      lhs,
      icon = function()
        return safe_get() and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
      end,
      desc = function()
        return (safe_get() and "Disable " or "Enable ") .. toggle.name
      end,
    },
  })
end

M.treesitter = M.wrap({
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
})

---@param buf? boolean
function M.format(buf)
  return M.wrap({
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

---@param opts? {values?: {[1]:any, [2]:any}, name?: string}
function M.option(option, opts)
  opts = opts or {}
  local name = opts.name or option
  local on = opts.values and opts.values[2] or true
  local off = opts.values and opts.values[1] or false
  return M.wrap({
    name = name,
    get = function()
      return vim.opt_local[option]:get() == on
    end,
    set = function(state)
      vim.opt_local[option] = state and on or off
    end,
  })
end

local nu = { number = true, relativenumber = true }
M.number = M.wrap({
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
})

M.diagnostics = M.wrap({
  name = "Diagnostics",
  get = function()
    return vim.diagnostic.is_enabled and vim.diagnostic.is_enabled()
  end,
  set = vim.diagnostic.enable,
})

M.inlay_hints = M.wrap({
  name = "Inlay Hints",
  get = function()
    return vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  end,
  set = function(state)
    vim.lsp.inlay_hint.enable(state, { bufnr = 0 })
  end,
})

---@type {k:string, v:any}[]
M._maximized = nil
M.maximize = M.wrap({
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
})

setmetatable(M, {
  __call = function(m, ...)
    return m.option(...)
  end,
})

return M
