local Util = require("lazyvim.util")

return {
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    cmd = "SymbolsOutline",
    opts = function()
      local Config = require("lazyvim.config")
      local defaults = require("symbols-outline.config").defaults
      local opts = {
        symbols = {},
        symbol_blacklist = {},
      }
      local filter = Config.kind_filter

      if type(filter) == "table" then
        filter = filter.default
        if type(filter) == "table" then
          for kind, symbol in pairs(defaults.symbols) do
            opts.symbols[kind] = {
              icon = Config.icons.kinds[kind] or symbol.icon,
              hl = symbol.hl,
            }
            if not vim.tbl_contains(filter, kind) then
              table.insert(opts.symbol_blacklist, kind)
            end
          end
        end
      end
      return opts
    end,
  },

  -- edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      local edgy_idx = Util.plugin.extra_idx("ui.edgy")
      local symbols_idx = Util.plugin.extra_idx("editor.symbols-outline")

      if edgy_idx and edgy_idx > symbols_idx then
        Util.warn(
          "The `edgy.nvim` extra must be **imported** before the `symbols-outline.nvim` extra to work properly.",
          {
            title = "LazyVim",
          }
        )
      end

      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "Symbols Outline",
        ft = "Outline",
        pinned = true,
        open = "SymbolsOutline",
      })
    end,
  },
}
