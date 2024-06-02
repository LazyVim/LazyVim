return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = function(_, opts)
      table.insert(opts.right, {
        title = "Database",
        ft = "dbui",
        pinned = true,
        open = "DBUI",
        size = { width = 0.25 },
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
