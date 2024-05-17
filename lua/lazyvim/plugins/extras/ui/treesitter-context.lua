-- Show context of the current function
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "LazyFile",
  opts = { mode = "cursor", max_lines = 3 },
  keys = {
    {
      "<leader>ut",
      function()
        local tsc = require("treesitter-context")
        tsc.toggle()
        if LazyVim.inject.get_upvalue(tsc.toggle, "enabled") then
          LazyVim.info("Enabled Treesitter Context", { title = "Option" })
        else
          LazyVim.warn("Disabled Treesitter Context", { title = "Option" })
        end
      end,
      desc = "Toggle Treesitter Context",
    },
  },
}
