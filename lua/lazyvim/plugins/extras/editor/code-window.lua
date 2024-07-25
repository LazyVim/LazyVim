return {
  "gorbit99/codewindow.nvim",
  opts = function()
    local codewindow = require("codewindow")
    codewindow.setup()
    codewindow.apply_default_keybinds()
  end,
}
