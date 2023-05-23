if not vim.g.vscode then
  return {}
end

local enabled = {
  "flit.nvim",
  "lazy.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  "mini.pairs",
  "mini.surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "vim-repeat",
}

local Config = require("lazy.core.config")
local Plugin = require("lazy.core.plugin")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false

local update_state = Plugin.update_state
---@diagnostic disable-next-line: duplicate-set-field
Plugin.update_state = function()
  -- Config.spec.disabled = {}
  for name, plugin in pairs(Config.plugins) do
    if not vim.tbl_contains(enabled, plugin.name) then
      Config.plugins[name] = nil
    end
  end
  update_state()
  Config.to_clean = {}
end

local map = vim.keymap.set

map("n", "<leader><space>", "<cmd>Find<cr>")
map("n", "<leader>/", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
map("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
