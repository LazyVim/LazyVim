# LazyVim

A starter template for Neovim using [lazy.nvim](https://github.com/folke/lazy.nvim)

![image](https://user-images.githubusercontent.com/292349/210136312-c211f781-6d51-46b0-a265-6098bdbb364d.png)

## ✅ Todo

- [ ] documentation
- [x] treesitter auto-install seems broken. Switch to `ensure_installed` instead?
- [x] list all plugins in readme
- [ ] test all-the-things

## File Structure

<pre>
~/.config/nvim
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── icons.lua
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
│       ├── ui.lua
│       └── util.lua
├── init.lua
├── lazy-lock.json
├── LICENSE
├── README.md
└── stylua.toml
</pre>

<!-- plugins:start -->

## Plugins

- [alpha-nvim](https://github.com/goolord/alpha-nvim)
- [catppuccin](https://github.com/catppuccin/nvim)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [dressing.nvim](https://github.com/stevearc/dressing.nvim)
- [flit.nvim](https://github.com/ggandor/flit.nvim)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [leap.nvim](https://github.com/ggandor/leap.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mini.bufremove](https://github.com/echasnovski/mini.bufremove)
- [mini.comment](https://github.com/echasnovski/mini.comment)
- [mini.pairs](https://github.com/echasnovski/mini.pairs)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [neoconf.nvim](https://github.com/folke/neoconf.nvim)
- [neodev.nvim](https://github.com/folke/neodev.nvim)
- [noice.nvim](https://github.com/folke/noice.nvim)
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
- [vim-illuminate](https://github.com/RRethy/vim-illuminate)
- [vim-startuptime](https://github.com/dstein64/vim-startuptime)
- [which-key.nvim](https://github.com/folke/which-key.nvim)

<!-- plugins:end -->
