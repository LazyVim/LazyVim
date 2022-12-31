# LazyVim

A starter template for Neovim using [lazy.nvim](https://github.com/folke/lazy.nvim)

![image](https://user-images.githubusercontent.com/292349/210136312-c211f781-6d51-46b0-a265-6098bdbb364d.png)

## ✅ Todo

- [ ] documentation
- [x] treesitter auto-install seems broken. Switch to `ensure_installed` instead?
- [x] list all plugins in readme
- [ ] test all-the-things

<!-- plugins:start -->

## File Structure

<pre>
~/.config/nvim
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       ├── lsp
│       │   ├── format.lua
│       │   ├── init.lua
│       │   ├── keymaps.lua
│       │   └── servers.lua
│       ├── api.lua
│       ├── coding.lua
│       ├── colorscheme.lua
│       ├── editor.lua
│       ├── treesitter.lua
│       └── ui.lua
├── init.lua
├── lazy-lock.json
├── README.md
└── stylua.toml
</pre>

## Plugins

- [alpha-nvim](https://github.com/goolord/alpha-nvim)
- [catppuccin](https://github.com/catppuccin/nvim)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mini.comment](https://github.com/echasnovski/mini.comment)
- [mini.pairs](https://github.com/echasnovski/mini.pairs)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [neoconf.nvim](https://github.com/folke/neoconf.nvim)
- [neodev.nvim](https://github.com/folke/neodev.nvim)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- [nvim-bufferline.lua](https://github.com/akinsho/nvim-bufferline.lua)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [which-key.nvim](https://github.com/folke/which-key.nvim)

<!-- plugins:end -->
