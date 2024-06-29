#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

-- Setup lazy.nvim
require("lazy.minit").busted({
  spec = {
    "LazyVim/starter",
    { "nvim-lua/plenary.nvim" },
    { "folke/lazy.nvim" },
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
})
