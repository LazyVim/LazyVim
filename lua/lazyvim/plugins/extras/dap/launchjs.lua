return {
  desc = "Enable .vscode/launch.json detection.",
  {
    "Joakker/lua-json5",
    build = LazyVim.is_win() and "pwsh -noni .\\install.ps1" or "./install.sh",
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "Joakker/lua-json5",
    },
    opts = function()
      local _filetypes = require("mason-nvim-dap.mappings.filetypes")
      local filetypes = vim.tbl_deep_extend("force", _filetypes, {
        ["node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
        ["pwa-node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
      })
      local dap_vscode = require("dap.ext.vscode")
      dap_vscode.json_decode = require("json5").parse
      dap_vscode.load_launchjs(nil, filetypes)
    end,
  },
}
