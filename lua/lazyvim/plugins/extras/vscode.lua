if not vim.g.vscode then
  return {}
end

local enabled = {
  "dial.nvim",
  "flit.nvim",
  "lazy.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  "mini.move",
  "mini.pairs",
  "mini.surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "ts-comments.nvim",
  "vim-repeat",
  "yanky.nvim",
  "LazyVim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

local map = LazyVim.keymap_set
local k = require("lazyvim.keymaps").get_keymaps()

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymapsDefaults",
  callback = function()
    map("n", k.vscode_find, "<cmd>Find<cr>")
    map("n", k.vscode_find_in_files, [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]])
    map("n", k.vscode_go_to_symbol, [[<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<cr>]])
  end,
})

function LazyVim.terminal()
  require("vscode").action("workbench.action.terminal.toggleTerminal")
end

return {
  {
    "LazyVim/LazyVim",
    config = function(_, opts)
      opts = opts or {}
      -- disable the colorscheme
      opts.colorscheme = function() end
      require("lazyvim").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
