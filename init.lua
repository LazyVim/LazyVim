require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.autocmds")
    require("config.keymaps")
  end,
})
