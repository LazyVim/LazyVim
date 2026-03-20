local M = {}

---@type LazyKeysLspSpec[]|nil
M._keys = {}

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], enabled?:(fun():boolean), code_action?:string}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], code_action?:string, enabled?:fun():boolean}

---@deprecated
---@return LazyKeysLspSpec[]
function M.get()
  LazyVim.warn({
    'Adding LSP keymaps via `require("lazyvim.plugins.lsp.keymaps").get()` is deprecated.',
    "Please set keymaps via the `keys` field in the LSP server config.",
    [[
```lua
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ['*'] = {
        keys = {
          { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", has = "definition"},
        },
      },
    },
  },
}
```]],
  }, { stacktrace = true })
  vim.schedule(function()
    if #M._keys > 0 then
      M.set({}, M._keys)
      M._keys = {}
    end
  end)
  return M._keys
end

---@param filter vim.lsp.get_clients.Filter
---@param spec LazyKeysLspSpec[]
function M.set(filter, spec)
  local Keys = require("lazy.core.handler.keys")
  for _, keys in pairs(Keys.resolve(spec)) do
    ---@cast keys LazyKeysLsp
    local filters = {} ---@type vim.lsp.get_clients.Filter[]
    if keys.code_action then
      filter = vim.tbl_extend("force", vim.deepcopy(filter), { method = "textDocument/codeAction" })
      filters[#filters + 1] = filter

      ---@param kinds? string[]
      local function has(kinds)
        for _, k in ipairs(kinds or {}) do
          if type(k) == "string" and vim.startswith(k, keys.code_action) then
            return true
          end
        end
      end

      local enabled = keys.enabled
      keys.enabled = function()
        if type(enabled) == "function" and not enabled() then
          return false
        end
        local clients = vim.lsp.get_clients(filter)
        for _, client in ipairs(clients) do
          -- check server cababilities first
          if has(vim.tbl_get(client, "server_capabilities", "codeActionProvider", "codeActionKinds")) then
            return true
          end
          -- check dynamic capabilities
          local regs = client.dynamic_capabilities:get("codeActionProvider")
          for _, reg in ipairs(regs or {}) do
            if has(vim.tbl_get(reg, "registerOptions", "codeActionKinds")) then
              return true
            end
          end
        end
        return false
      end
    elseif keys.has then
      local methods = type(keys.has) == "string" and { keys.has } or keys.has --[[@as string[] ]]
      for _, method in ipairs(methods) do
        method = method:find("/") and method or ("textDocument/" .. method)
        filters[#filters + 1] = vim.tbl_extend("force", vim.deepcopy(filter), { method = method })
      end
    else
      filters[#filters + 1] = filter
    end

    for _, f in ipairs(filters) do
      local opts = Keys.opts(keys)
      ---@cast opts snacks.keymap.set.Opts
      opts.lsp = f
      opts.enabled = keys.enabled
      Snacks.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
