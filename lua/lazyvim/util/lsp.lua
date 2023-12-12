local Util = require("lazyvim.util")

---@class lazyvim.util.lsp
local M = {}

---@alias lsp.Client.filter {id?: number, bufnr?: number, name?: string, method?: string, filter?:fun(client: lsp.Client):boolean}

---@param opts? lsp.Client.filter
function M.get_clients(opts)
  local ret = {} ---@type lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client lsp.Client
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

---@param from string
---@param to string
function M.on_rename(from, to)
  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method("workspace/willRenameFiles") then
      ---@diagnostic disable-next-line: invisible
      local resp = client.request_sync("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
end

---@return _.lspconfig.options
function M.get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

---@param server string
---@param cond fun( root_dir, config): boolean
function M.disable(server, cond)
  local util = require("lspconfig.util")
  local def = M.get_config(server)
  ---@diagnostic disable-next-line: undefined-field
  def.document_config.on_new_config = util.add_hook_before(def.document_config.on_new_config, function(config, root_dir)
    if cond(root_dir, config) then
      config.enabled = false
    end
  end)
end

---@param opts? LazyFormatter| {filter?: (string|lsp.Client.filter)}
function M.formatter(opts)
  opts = opts or {}
  local filter = opts.filter or {}
  filter = type(filter) == "string" and { name = filter } or filter
  ---@cast filter lsp.Client.filter
  ---@type LazyFormatter
  local ret = {
    name = "LSP",
    primary = true,
    priority = 1,
    format = function(buf)
      M.format(Util.merge(filter, { bufnr = buf }))
    end,
    sources = function(buf)
      local clients = M.get_clients(Util.merge(filter, { bufnr = buf }))
      ---@param client lsp.Client
      local ret = vim.tbl_filter(function(client)
        return client.supports_method("textDocument/formatting")
          or client.supports_method("textDocument/rangeFormatting")
      end, clients)
      ---@param client lsp.Client
      return vim.tbl_map(function(client)
        return client.name
      end, ret)
    end,
  }
  return Util.merge(ret, opts) --[[@as LazyFormatter]]
end

---@alias lsp.Client.format {timeout_ms?: number, format_options?: table} | lsp.Client.filter

---@param opts? lsp.Client.format
function M.format(opts)
  opts = vim.tbl_deep_extend("force", {}, opts or {}, require("lazyvim.util").opts("nvim-lspconfig").format or {})
  local ok, conform = pcall(require, "conform")
  -- use conform for formatting with LSP when available,
  -- since it has better format diffing
  if ok then
    opts.formatters = {}
    opts.lsp_fallback = true
    conform.format(opts)
  else
    vim.lsp.buf.format(opts)
  end
end

return M
