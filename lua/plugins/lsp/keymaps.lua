local M = {}

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

function M.on_attach(client, buffer)
  local cap = client.server_capabilities

  local function map(lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(opts.mode or "n", lhs, rhs, { silent = true, buffer = buffer, expr = opts.expr, desc = opts.desc })
  end

  map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" } })
  map("<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  map("<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
  map("<leader>xd", "<cmd>Telescope diagnostics<cr>", { desc = "Telescope Diagnostics" })
  map("gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Goto Definition" })
  map("gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
  map("gR", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble References" })
  map("gD", "<cmd>Telescope lsp_declarations<CR>", { desc = "Goto Declaration" })
  map("gI", "<cmd>Telescope lsp_implementations<CR>", { desc = "Goto Implementation" })
  map("gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Goto Type Definition" })
  map("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature Help", mode = { "i", "n" } })
  map("K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
  map("[d", M.diagnostic_goto(true), { desc = "Next Diagnostic" })
  map("]d", M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
  map("]e", M.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  map("[e", M.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  map("]w", M.diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
  map("[w", M.diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })

  if cap.documentFormatting then
    map("<leader>cf", require("plugins.lsp.format").format, { desc = "Format Document" })
  end

  if cap.documentRangeFormatting then
    map("<leader>cf", require("plugins.lsp.format").format, { desc = "Format Range", mode = "v" })
  end

  if cap.renameProvider then
    map("<leader>cr", function()
      if pcall(require, "inc_rename") then
        return ":IncRename " .. vim.fn.expand("<cword>")
      else
        vim.lsp.buf.rename()
      end
    end, { expr = true, desc = "Rename" })
  end

  if client.name == "tsserver" and pcall(require, "typescript") then
    map("<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { desc = "Organize Imports" })
    map("<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File" })
  end
end

return M
