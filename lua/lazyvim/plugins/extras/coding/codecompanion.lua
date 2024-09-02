return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionToggle", "CodeCompanionAdd", "CodeCompanionChat" },

    opts = function()
      local options = require("codecompanion.config")
      local user = vim.env.USER or "User"

      options.strategies.chat.roles = {
        llm = "  CodeCompanion",
        user = "  " .. user:sub(1, 1):upper() .. user:sub(2),
      }

      options.strategies.chat.keymaps.close.modes = {
        n = "q",
        i = "<C-c>",
      }
      options.strategies.chat.keymaps.stop.modes.n = "<Esc>"
      options.strategies.chat.keymaps.send.modes.n = "<CR>"

      return options
    end,

    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Prompt Actions (CodeCompanion)" },
      { "<leader>aa", "<cmd>CodeCompanionToggle<cr>", mode = { "n", "v" }, desc = "Toggle (CodeCompanion)" },
      { "<leader>ac", "<cmd>CodeCompanionAdd<cr>", mode = "v", desc = "Add code to CodeCompanion" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = "n", desc = "Inline prompt (CodeCompanion)" },
    },
  },

  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion Chat",
        size = { width = 50 },
      })
    end,
  },
}
