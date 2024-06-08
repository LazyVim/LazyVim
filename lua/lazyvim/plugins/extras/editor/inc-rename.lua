-- enhances the 'IncRename' command cleaning
-- retaining only 'IncRename ' if the command starts with it and has additional characters.
local function enhance_rename_cleaner()
  local cmd_line = vim.fn.getcmdline()
  local prefix = "IncRename "
  local prefix_length = #prefix

  if cmd_line:sub(1, prefix_length) == prefix and #cmd_line > prefix_length then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-u>" .. prefix, true, true, true), "n")
  else
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-u>", true, true, true), "n")
  end
end

vim.keymap.set("c", "<C-u>", enhance_rename_cleaner, { noremap = true, silent = false })
return {

  -- Rename with cmdpreview
  recommended = true,
  desc = "Incremental LSP renaming based on Neovim's command-preview feature",
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },

  -- LSP Keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>cr",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename (inc-rename.nvim)",
        has = "rename",
      }
    end,
  },

  --- Noice integration
  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      presets = { inc_rename = true },
    },
  },
}
