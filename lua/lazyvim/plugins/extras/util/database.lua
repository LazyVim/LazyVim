return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    optional = true,
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
      vim.g.db_ui_auto_execute_table_helpers = 1
    end,
    opts = function(_, opts)
      table.insert(opts.right, {
        title = "Database",
        ft = "dbui",
        pinned = false,
        open = "DBUI",
        size = { width = 0.25 },
      })
      table.insert(opts.bottom, {
        title = "DB Query Result",
        ft = "dbout",
      })
    end,
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUIToggle",
      "DBUIAddConnection",
    },
    init = function()
      local wk = require("which-key")
      local dbtoggle = function()
        if _G.LazyVim.is_loaded("vim-dadbod-ui") then
          return { "<cmd>DBUIToggle<CR>", "Database Explorer", silent = true }
        else
          return { "<cmd>Lazy load vim-dadbod-ui | DBUIToggle<CR>", "Database Explorer", silent = true }
        end
      end
      wk.register({
        uD = {
          name = "Database UI",
          e = dbtoggle(),
          a = { "<cmd>DBUIAddConnection<CR>", "Add Database Connection", silent = true },
        },
      }, { prefix = "<leader>" })
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
