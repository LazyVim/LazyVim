local k = require("lazyvim.keymaps").get_keymaps()

return {
  -- Disable `<leader>cs` keymap so it doesn't conflict with `outline.nvim`
  {
    "folke/trouble.nvim",
    optional = true,
    keys = {
      { k.trouble_symbols_toggle, false },
    },
  },
  {
    "hedyhli/outline.nvim",
    keys = { { k.trouble_symbols_toggle, "<cmd>Outline<cr>", desc = "Toggle Outline" } },
    cmd = "Outline",
    opts = function()
      local defaults = require("outline.config").defaults
      local opts = {
        symbols = {
          icons = {},
          filter = vim.deepcopy(LazyVim.config.kind_filter),
        },
        keymaps = {},
      }

      local keymaps = {
        up_and_jump = k.outline_up_and_jump,
        down_and_jump = k.outline_down_and_jump,
      }
      for key, value in pairs(keymaps) do
        if value and value ~= "" then
          opts.keymaps[key] = value
        end
      end

      for kind, symbol in pairs(defaults.symbols.icons) do
        opts.symbols.icons[kind] = {
          icon = LazyVim.config.icons.kinds[kind] or symbol.icon,
          hl = symbol.hl,
        }
      end
      return opts
    end,
  },

  -- edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      local edgy_idx = LazyVim.plugin.extra_idx("ui.edgy")
      local symbols_idx = LazyVim.plugin.extra_idx("editor.outline")

      if edgy_idx and edgy_idx > symbols_idx then
        LazyVim.warn(
          "The `edgy.nvim` extra must be **imported** before the `outline.nvim` extra to work properly.",
          { title = "LazyVim" }
        )
      end

      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "Outline",
        ft = "Outline",
        pinned = true,
        open = "Outline",
      })
    end,
  },
}
