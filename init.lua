vim.api.nvim_echo({
  {
    "Do not use this repository directly\n",
    "ErrorMsg",
  },
  {
    "Please check the docs on how to get started with LazyVim\n",
    "WarningMsg",
  },
  { "Press any key to exit", "MoreMsg" },
}, true, {})

vim.fn.getchar()
vim.cmd([[quit]])
