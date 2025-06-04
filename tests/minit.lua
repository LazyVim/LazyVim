#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

-- Setup lazy.nvim
require("lazy.minit").setup({
  spec = {
    { dir = vim.uv.cwd() },
    { "LazyVim/starter" },
    { "nvim-treesitter/nvim-treesitter" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    { "mason-org/mason.nvim", version = "^1.0.0" },
    { "echasnovski/mini.icons", opts = {} },
  },
})
