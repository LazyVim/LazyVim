-- Show context of the current function
local k = require("lazyvim.keymaps").get_keymaps().extras.ui.treesitter_context

return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  opts = function()
    local tsc = require("treesitter-context")

    LazyVim.toggle.map(k.toggle, {
      name = "Treesitter Context",
      get = tsc.enabled,
      set = function(state)
        if state then
          tsc.enable()
        else
          tsc.disable()
        end
      end,
    })

    return { mode = "cursor", max_lines = 3 }
  end,
}
