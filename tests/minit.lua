#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

-- Setup lazy.nvim
require("lazy.minit").setup({
  spec = {
    { dir = vim.uv.cwd() },
    { "LazyVim/starter" },
    { "nvim-treesitter/nvim-treesitter" },
    { "mason-org/mason-lspconfig.nvim" },
    { "mason-org/mason.nvim" },
    { "nvim-mini/mini.icons", opts = {} },
  },
})
