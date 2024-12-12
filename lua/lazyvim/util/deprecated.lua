local M = {}

M.moved = {
  lsp = {
    rename_file = { "Snacks.rename.rename_file" },
    on_rename = { "Snacks.rename.on_rename_file" },
    words = { "Snacks.words" },
  },
  terminal = {
    open = { "Snacks.terminal" },
    __call = { "Snacks.terminal" },
  },
  ui = {
    statuscolumn = { "Snacks.statuscolumn" },
    bufremove = { "Snacks.bufdelete" },
    fg = {
      "{ fg = Snacks.util.color(...) }",
      fn = function(...)
        return { fg = Snacks.util.color(...) }
      end,
    },
  },
}

---@param name string
---@param mod table
function M.decorate(name, mod)
  if not M.moved[name] then
    return mod
  end
  setmetatable(mod, {
    __call = function(_, ...)
      local to = M.moved[name].__call[1]
      LazyVim.deprecate("LazyVim." .. name, to)
      local ret = vim.tbl_get(_G, unpack(vim.split(to, ".", { plain = true })))
      return ret(...)
    end,
    __index = function(_, k)
      if M.moved[name][k] then
        local to = M.moved[name][k][1]
        LazyVim.deprecate("LazyVim." .. name .. "." .. k, to)
        if M.moved[name][k].fn then
          return M.moved[name][k].fn
        end
        local ret = vim.tbl_get(_G, unpack(vim.split(to, ".", { plain = true })))
        return ret
      end
      return nil
    end,
  })
end

function M.lazygit()
  LazyVim.deprecate("LazyVim.lazygit", "Snacks.lazygit")
  return Snacks.lazygit
end

function M.toggle()
  LazyVim.deprecate("LazyVim.toggle", "Snacks.toggle")
  return {
    map = function() end,
    wrap = function()
      return {}
    end,
  }
end

return M
