local k = require("lazyvim.keymaps").get_keymaps()

return {

  { "nvimdev/dashboard-nvim", enabled = false },
  { "echasnovski/mini.starter", enabled = false },
  -- Dashboard. This runs when neovim starts, and is what displays
  -- the "LAZYVIM" banner.
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
           ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
           ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
           ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
           ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
           ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
           ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      -- stylua: ignore
      dashboard.section.buttons.val = {}
      local actions = {
        { k.dashboard_find_file, " " .. " Find file", LazyVim.pick() },
        { k.dashboard_new_file, " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]] },
        { k.dashboard_recent_files, " " .. " Recent files", LazyVim.pick("oldfiles") },
        { k.dashboard_find_text, " " .. " Find text", LazyVim.pick("live_grep") },
        { k.dashboard_config, " " .. " Config", LazyVim.pick.config_files() },
        { k.dashboard_restore_session, " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]] },
        { k.dashboard_lazy_extras, " " .. " Lazy Extras", "<cmd> LazyExtras <cr>" },
        { k.dashboard_lazy, "󰒲 " .. " Lazy", "<cmd> Lazy <cr>" },
        { k.dashboard_quit, " " .. " Quit", "<cmd> qa <cr>" },
      }

      for _, action in ipairs(actions) do
        if action[1] and action[1] ~= "" then
          table.insert(dashboard.section.buttons.val, dashboard.button(action[1], action[2], action[3]))
        end
      end

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
