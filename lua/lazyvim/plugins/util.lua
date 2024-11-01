local k = require("lazyvim.keymaps").get_keymaps()

return {

  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { k.persistence_restore_session, function() require("persistence").load() end, desc = "Restore Session" },
      { k.persistence_select_session, function() require("persistence").select() end,desc = "Select Session" },
      { k.persistence_restore_last_session, function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { k.persistence_skip_current_session, function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}
