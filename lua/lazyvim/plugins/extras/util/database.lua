return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      right = {
        {
          ft = "dbui",
          pinned = true,
          open = "DBUI",
        },
      },
      options = {
        right = { size = 40 },
      },
    },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      local wk = require("which-key")
      local wkopts = function(keymaps, description)
        return { keymaps, description, noremap = true, silent = true }
      end
      wk.register({
        uD = {
          name = "Database UI",
          e = wkopts("<cmd>DBUI<CR>", "Database Explorer"),
          a = wkopts("<cmd>DBUIAddConnection<CR>", "Add Database Connection"),
        },
      }, { prefix = "<leader>" })
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
