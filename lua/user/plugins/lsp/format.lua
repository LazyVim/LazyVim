local M = {}

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    vim.notify("enabled format on save")
  else
    vim.notify("disabled format on save")
  end
end

function M.format()
  if M.autoformat then
    vim.lsp.buf.format()
  end
end

function M.nls_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

function M.on_attach(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  local enable = false
  if M.nls_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.server_capabilities.documentFormattingProvider = enable
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat", {}),
      buffer = 0,
      callback = function()
        M.format()
      end,
    })
  end
end

return M
