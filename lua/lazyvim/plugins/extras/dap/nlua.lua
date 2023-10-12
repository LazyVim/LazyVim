local Util = require("lazyvim.util")

return {
  "mfussenegger/nvim-dap",

  launch = function(host, port)
    if vim.g.nlua then
      return
    end
    vim.o.cmdheight = 10
    local osv = require("osv")
    osv.launch({
      port = port,
      host = host,
      args = { "--cmd", "lua vim.g.nlua = true", "--cmd", "set cmdheight=10" },
    })
    vim.defer_fn(function()
      vim.cmd([[luafile %]])
    end, 2000)
  end,

  dependencies = {
    {
      "jbyuki/one-small-step-for-vimkind",
      -- stylua: ignore
      config = function()
        local dap = require("dap")
        dap.adapters.nlua = function(callback, conf)
          local adapter = {
            type = "server",
            host = conf.host or "127.0.0.1",
            port = conf.port or 8086,
          }
          if conf.start_neovim then
            local dap_run = dap.run
            dap.run = function(c)
              adapter.port = c.port
              adapter.host = c.host
            end
            require("osv").run_this()
            dap.run = dap_run
          end
          callback(adapter)
        end
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Run this file",
            start_neovim = {},
          },
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance (port = 8086)",
            port = 8086,
          },
        }
      end,
    },
  },
}
