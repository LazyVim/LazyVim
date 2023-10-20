local sql_ft = { "sql", "mysql", "plsql" }

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "sql", "mysql", "plsql" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "sql" })
      end
    end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.right, {
        title = "Database",
        ft = "dbui",
        pinned = true,
        open = function()
          vim.cmd("DBUI")
        end,
      })

      table.insert(opts.bottom, {
        title = "DB Query Result",
        ft = "dbout",
      })
    end,
  },
  {
    "tpope/vim-dadbod",
    cmd = "DB",
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = sql_ft,
        init = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = sql_ft,
            callback = function()
              ---@diagnostic disable-next-line: missing-fields
              local cmp = require("cmp")
              local global_sources = cmp.get_config().sources
              local buffer_sources = {}

              -- add globally defined sources (see separate nvim-cmp config)
              -- this makes e.g. luasnip snippets available since luasnip is configured globally
              if global_sources then
                for _, source in ipairs(global_sources) do
                  table.insert(buffer_sources, { name = source.name })
                end
              end

              -- add vim-dadbod-completion source
              table.insert(buffer_sources, { name = "vim-dadbod-completion" })

              -- update sources for the current buffer
              cmp.setup.buffer({ sources = buffer_sources })
            end,
          })
        end,
      },
      { "jsborjesson/vim-uppercase-sql", ft = sql_ft },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
      "tpope/vim-dadbod",
    },
    init = function()
      local data_path = vim.fn.stdpath("data")

      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"

      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_use_nvim_notify = true

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
    end,
  },
}
