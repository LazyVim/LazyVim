return {
  "mfussenegger/nvim-dap",
  dependencies = "stevearc/overseer.nvim",
  opts = function()
    require("overseer").patch_dap(true)
    require("dap.ext.vscode").json_decode = require("overseer.json").decode
  end,
}
