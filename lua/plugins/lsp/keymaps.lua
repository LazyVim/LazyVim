local M = {}

function M.on_attach(client, buffer)
  local cap = client.server_capabilities

  require("which-key").register({
    buffer = buffer,
    ["<leader>"] = {
      c = {
        name = "+code",
        {
          cond = client.name == "tsserver",
          o = { "<cmd>:TypescriptOrganizeImports<CR>", "Organize Imports" },
          R = { "<cmd>:TypescriptRenameFile<CR>", "Rename File" },
        },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", cond = cap.renameProvider },
        a = {
          { vim.lsp.buf.code_action, "Code Action" },
          { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
        },
        f = {
          {
            require("plugins.lsp.format").format,
            "Format Document",
            cond = cap.documentFormatting,
          },
          {
            require("plugins.lsp.format").format,
            "Format Range",
            cond = cap.documentRangeFormatting,
            mode = "v",
          },
        },
        d = { vim.diagnostic.open_float, "Line Diagnostics" },
        l = {
          name = "+lsp",
          i = { "<cmd>LspInfo<cr>", "Lsp Info" },
        },
      },
      x = {
        d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
      },
    },
    g = {
      name = "+goto",
      d = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
      r = { "<cmd>Telescope lsp_references<cr>", "References" },
      R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
      D = { "<cmd>Telescope lsp_declarations<CR>", "Goto Declaration" },
      I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
      t = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
    },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help", mode = { "n", "i" } },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Next Diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Prev Diagnostic" },
    ["[e"] = { "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", "Next Error" },
    ["]e"] = { "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", "Prev Error" },
    ["[w"] = {
      "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARNING})<CR>",
      "Next Warning",
    },
    ["]w"] = {
      "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARNING})<CR>",
      "Prev Warning",
    },
  })
end

return M
