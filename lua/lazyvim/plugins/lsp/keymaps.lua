local M = {}
local k = require("lazyvim.keymaps").get_keymaps()

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@return LazyKeysLspSpec[]
function M.get()
  if M._keys then
    return M._keys
  end
  local actions = {
    { k.lang_lsp_info, "<cmd>LspInfo<cr>", desc = "Lsp Info" },
    { k.lang_go_to_definition, vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
    { k.lang_references, vim.lsp.buf.references, desc = "References", nowait = true },
    { k.lang_go_to_implementation, vim.lsp.buf.implementation, desc = "Goto Implementation" },
    { k.lang_go_to_type_definition, vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
    { k.lang_go_to_declaration, vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { k.lang_hover, vim.lsp.buf.hover, desc = "Hover" },
    { k.lang_signature_help, vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    {
      k.lang_insert_signature_help,
      vim.lsp.buf.signature_help,
      mode = "i",
      desc = "Signature Help",
      has = "signatureHelp",
    },
    { k.lang_code_action, vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    { k.lang_run_codelens, vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    {
      k.lang_refresh_codelens,
      vim.lsp.codelens.refresh,
      desc = "Refresh & Display Codelens",
      mode = { "n" },
      has = "codeLens",
    },
    {
      k.lang_rename_file,
      LazyVim.lsp.rename_file,
      desc = "Rename File",
      mode = { "n" },
      has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
    },
    { k.lang_rename, vim.lsp.buf.rename, desc = "Rename", has = "rename" },
    { k.lang_source_action, LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
    {
      k.lang_next_reference,
      function()
        LazyVim.lsp.words.jump(vim.v.count1)
      end,
      has = "documentHighlight",
      desc = "Next Reference",
      cond = function()
        return LazyVim.lsp.words.enabled
      end,
    },
    {
      k.lang_prev_reference,
      function()
        LazyVim.lsp.words.jump(-vim.v.count1)
      end,
      has = "documentHighlight",
      desc = "Prev Reference",
      cond = function()
        return LazyVim.lsp.words.enabled
      end,
    },
    {
      k.lang_cycle_next_reference,
      function()
        LazyVim.lsp.words.jump(vim.v.count1, true)
      end,
      has = "documentHighlight",
      desc = "Next Reference",
      cond = function()
        return LazyVim.lsp.words.enabled
      end,
    },
    {
      k.lang_cycle_prev_reference,
      function()
        LazyVim.lsp.words.jump(-vim.v.count1, true)
      end,
      has = "documentHighlight",
      desc = "Prev Reference",
      cond = function()
        return LazyVim.lsp.words.enabled
      end,
    },
  }
  M._keys = {}

  for _, action in ipairs(actions) do
    if action[1] and action[1] ~= "" then
      table.insert(M._keys, action)
    end
  end

  return M._keys
end

---@param method string|string[]
function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find("/") and method or "textDocument/" .. method
  local clients = LazyVim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return LazyKeysLsp[]
function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = LazyVim.opts("nvim-lspconfig")
  local clients = LazyVim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      LazyVim.keymap_set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
