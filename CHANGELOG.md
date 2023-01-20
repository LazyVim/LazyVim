# Changelog

## [1.0.0](https://github.com/LazyVim/LazyVim/compare/v0.4.0-alpha...v1.0.0) (2023-01-20)


### Features

* 1.0.0 release ([75e30fc](https://github.com/LazyVim/LazyVim/commit/75e30fc6a3df9857ff6c9307d8d80563004c59f7))

## [0.4.0-alpha](https://github.com/LazyVim/LazyVim/compare/v0.3.0-alpha...v0.4.0-alpha) (2023-01-20)


### ⚠ BREAKING CHANGES

* **buffer:** remove `<leader>b[`, `<leader>b]` in favor of `]b` and `[b`
* **treesitter:** use `<bs>` in visual mode to shrink delection. Fixes #71

### Features

* **buffer:** remove `&lt;leader&gt;b[`, `<leader>b]` in favor of `]b` and `[b` ([3362f0a](https://github.com/LazyVim/LazyVim/commit/3362f0abc4a70c82dc1ea81fca169e14bbb61c6a))
* **keymaps:** added `[b` and `]b` to switch buffers ([c2693e2](https://github.com/LazyVim/LazyVim/commit/c2693e2d16ffc7f082d7b22b0da2d448a34b3778))
* **lsp:** ignore lsp servers where setting is set to `false` ([5d3e126](https://github.com/LazyVim/LazyVim/commit/5d3e126b63c3ebebc01cf7f847464562c553bf32))


### Bug Fixes

* **lsp:** there is no declaration in telescope, use vim.lsp ([#78](https://github.com/LazyVim/LazyVim/issues/78)) ([fe4b924](https://github.com/LazyVim/LazyVim/commit/fe4b92492ca1c8bba826609ed2c34fd927068e0e))


### Code Refactoring

* **treesitter:** use `&lt;bs&gt;` in visual mode to shrink delection. Fixes [#71](https://github.com/LazyVim/LazyVim/issues/71) ([ba00402](https://github.com/LazyVim/LazyVim/commit/ba0040230e56edb04ca26702f0816392a87405fd))

## [0.3.0-alpha](https://github.com/LazyVim/LazyVim/compare/v0.2.2-alpha...v0.3.0-alpha) (2023-01-17)


### ⚠ BREAKING CHANGES

* **todo:** `<leader>xtt` => `<leader>xT`
* **todo:** moved search todo to `<leader>st`
* **telescope:** moved search diagnostics to `<leader>sd`

### Bug Fixes

* **keymaps:** added Inspect to `&lt;leader&gt;ui` ([8d8626c](https://github.com/LazyVim/LazyVim/commit/8d8626c5d91ed0d5125dd2560271600c35bcf485))


### Code Refactoring

* **telescope:** moved search diagnostics to `&lt;leader&gt;sd` ([254d3a0](https://github.com/LazyVim/LazyVim/commit/254d3a092184b4327049ac7a0bc5202673f92c64))
* **todo:** `&lt;leader&gt;xtt` => `<leader>xT` ([88c112f](https://github.com/LazyVim/LazyVim/commit/88c112fc3ae298fe3a0414a689cbd715db0ad2e3))
* **todo:** moved search todo to `&lt;leader&gt;st` ([7563b36](https://github.com/LazyVim/LazyVim/commit/7563b361b8d7f62a75a6eb4e234326773ffbc89b))

## [0.2.2-alpha](https://github.com/LazyVim/LazyVim/compare/v0.2.1-alpha...v0.2.2-alpha) (2023-01-16)


### Bug Fixes

* **windows:** set version=false for treesitter. Last release is too old and broken on Windows. Fixes [#2](https://github.com/LazyVim/LazyVim/issues/2) ([876d52f](https://github.com/LazyVim/LazyVim/commit/876d52fee3e41d2c6d166bc05b06072fe443fb5e))

## [0.2.1-alpha](https://github.com/LazyVim/LazyVim/compare/v0.2.0-alpha...v0.2.1-alpha) (2023-01-16)


### Features

* **keymaps:** added shortcuts for split and vsplit `&lt;leader&gt;-` and `<leader>|` ([5a99809](https://github.com/LazyVim/LazyVim/commit/5a99809844da64d18f2f1b9f5a3ef94f276e203e))
* **mini.surround:** added lazy keys with descriptions to mini.surround ([bf31ecc](https://github.com/LazyVim/LazyVim/commit/bf31eccae20a7169024c115af52f134aef806cf5))
* **treesitter:** added incremental selection ([3af1922](https://github.com/LazyVim/LazyVim/commit/3af1922f216f737cbcfbe44c0948dfc9688bbb63))


### Bug Fixes

* **version:** don't use version for schemastore and nvim-cmp. Last version is too old ([3d498ee](https://github.com/LazyVim/LazyVim/commit/3d498ee7136be179aada077d39c14adff6056187))

## [0.2.0-alpha](https://github.com/LazyVim/LazyVim/compare/v0.1.0-alpha...v0.2.0-alpha) (2023-01-16)


### ⚠ BREAKING CHANGES

* **telescope:** moved most `help` keymaps under `<leader>s` (search)
* **neotree:** keymaps are now under `<leader>fe` and `<leader>fE`
* **noice:** noice keymaps are now under `<leader>sn`
* **keymaps:** terminal keymaps are now under `<leader>ft` and `<leader>fT`
* **keymaps:** redraw is now mapped to `<leader>ur` (UI redraw)
* **keymaps:** toggle keymaps can now be found under UI `<leader>u`
* **colorscheme:** LazyVim now loads the colorscheme configured with config.colorscheme. See the docs for more info
* **config:** LazyVim can now be configured like any other plugin with {"LazyVim/LazyVim", opts = ... }. `config.settings` is deprecated
* **keymaps:** remove keymaps for [p and ]p

### Features

* added vim-repeat. Fixes [#56](https://github.com/LazyVim/LazyVim/issues/56) ([688436c](https://github.com/LazyVim/LazyVim/commit/688436c9af696f978c56f807e78fbc2df0314314))
* **autocmds:** rebalance windows on resize ([6674a3a](https://github.com/LazyVim/LazyVim/commit/6674a3accf83b86ab9c978db002763f46c3f09bc))
* **colorscheme:** LazyVim now loads the colorscheme configured with config.colorscheme. See the docs for more info ([08f6375](https://github.com/LazyVim/LazyVim/commit/08f6375e4caa33759dd29c0bb022de0ae2ff5e3f))
* **config:** LazyVim can now be configured like any other plugin with {"LazyVim/LazyVim", opts = ... }. `config.settings` is deprecated ([36c84f4](https://github.com/LazyVim/LazyVim/commit/36c84f47c9f55ea818384d953c8fbeb7e99de8e6))
* **config:** show an error when the needed version of `lazy.nvim` is too old ([7b94382](https://github.com/LazyVim/LazyVim/commit/7b943822db090e2eebeada5ace0b3b31fd772b89))
* **keymaps:** added `&lt;leader&gt;r` to redraw and clear hlsearch ([1d6ce4f](https://github.com/LazyVim/LazyVim/commit/1d6ce4fc57f99188af410e91e632b11428ef3d22))
* **keymaps:** redraw is now mapped to `&lt;leader&gt;ur` (UI redraw) ([1e4b958](https://github.com/LazyVim/LazyVim/commit/1e4b958b4a4d9f9ac3b54b981415ed8888ff2faf))
* **keymaps:** remove keymaps for [p and ]p ([73b38e6](https://github.com/LazyVim/LazyVim/commit/73b38e6187d0801fed43fbac55ff4db950ffe20d))
* **keymaps:** toggle keymaps can now be found under UI `&lt;leader&gt;u` ([ed06282](https://github.com/LazyVim/LazyVim/commit/ed0628286f9e896932286f29c163592dad079ce3))
* **lsp:** added `&lt;c-k&gt;` for signature help in insert mode ([b17ede1](https://github.com/LazyVim/LazyVim/commit/b17ede1ae2acc3ef0398c85f5780083170b7acbc))
* **lsp:** added `opts.autoformat` to be able to disable autoformat by default. Fixes [#65](https://github.com/LazyVim/LazyVim/issues/65) ([b278b06](https://github.com/LazyVim/LazyVim/commit/b278b062ecac5bef54a6fef3513655b93dd3032f))
* **lsp:** allow overriding options for vim.lsp.buf.format. Fixes [#51](https://github.com/LazyVim/LazyVim/issues/51) ([40d363c](https://github.com/LazyVim/LazyVim/commit/40d363cf3f468a1cc4ea482eaabbd5c7e224f397))
* **lsp:** make diagnostics configurable with `{"neovim/nvim-lspconfig", opts = {diagnostics = {}}}`. Fixes [#55](https://github.com/LazyVim/LazyVim/issues/55) ([1efc925](https://github.com/LazyVim/LazyVim/commit/1efc925d16b57659cbb9af5a1579cb1b9ee9643f))
* **neo-tree:** added `&lt;leader&gt;e` and `<leader>E` to toggle neo-tree ([542920f](https://github.com/LazyVim/LazyVim/commit/542920fb8249d45d1e9ddbf6517a8f8539769eda))
* **neo-tree:** load neo-tree when specifying a direcory on the cmdline ([81d798f](https://github.com/LazyVim/LazyVim/commit/81d798fdaa5bf49737969e0f15af4a90621a0a61))
* **notify:** delay notifs till replaced or at most 500ms to prevent more prompts ([701337f](https://github.com/LazyVim/LazyVim/commit/701337fac8cb1de0f3e31400cef30b053762320f))
* **notify:** lazy-load nvim-notify to show proper notifs before Noice loads ([7406313](https://github.com/LazyVim/LazyVim/commit/74063135d838b0ed9fe1a8d0e777c8cfe83ae28f))
* **util:** use lazy's notify instead of `vim.notify` ([48d1e8d](https://github.com/LazyVim/LazyVim/commit/48d1e8df12795cf559f704223b63e76259998582))


### Bug Fixes

* add tsx treesitter to typescript lang module ([#48](https://github.com/LazyVim/LazyVim/issues/48)) ([a33d906](https://github.com/LazyVim/LazyVim/commit/a33d90652428ef4224b43e8f4cbec447c85fb117))
* **autocmds:** load autocmds during startup when argc &gt; 0. Fixes [#34](https://github.com/LazyVim/LazyVim/issues/34) ([318b56c](https://github.com/LazyVim/LazyVim/commit/318b56c1c425d90c71c0b63c6ec7655a8f019fa1))
* **bufferline:** load bufferline on VeryLazy event ([#35](https://github.com/LazyVim/LazyVim/issues/35)) ([#36](https://github.com/LazyVim/LazyVim/issues/36)) ([207beaf](https://github.com/LazyVim/LazyVim/commit/207beafda215e4657bf083b94c80d455fc5de86b))
* **format:** typo timeout -&gt; timeout_ms ([f9de5d0](https://github.com/LazyVim/LazyVim/commit/f9de5d0e8a1a8782c9b2cc07f6964f6192f36b29))
* **json:** correct case for SchemaStore.nvim ([04a898a](https://github.com/LazyVim/LazyVim/commit/04a898a326d6e719ca82ce062d82355feb0f3a1e))
* **keymaps:** `&lt;leader&gt;ur` now does the same as Neovim's better `<c-l>` ([30dc8c5](https://github.com/LazyVim/LazyVim/commit/30dc8c57326aaf772f0e789f9a2523c63b89e7fe))
* **keymaps:** add missing wk entries for buffer switching; lowercase UI in menu ([#45](https://github.com/LazyVim/LazyVim/issues/45)) ([46dba8f](https://github.com/LazyVim/LazyVim/commit/46dba8f67e96cb8aa5496351696b11b49093ecc8))
* **keymaps:** Add unique keymap to toggle relative number ([#60](https://github.com/LazyVim/LazyVim/issues/60)) ([e03471d](https://github.com/LazyVim/LazyVim/commit/e03471df70a666d68285add56d3ed319d8cc009a))
* **keymaps:** Resolve comment after PR got merged ([#61](https://github.com/LazyVim/LazyVim/issues/61)) ([30b7215](https://github.com/LazyVim/LazyVim/commit/30b7215de80a215c9bc72640505ea76431ff515c))
* **lsp:** ']d' & '[d' was reversed ([#58](https://github.com/LazyVim/LazyVim/issues/58)) ([cbd5342](https://github.com/LazyVim/LazyVim/commit/cbd534242c46eda5d564e6d03daebe18b7f53363))
* **luasnip:** don't set remap=true for `&lt;tab&gt;`. Fixes [#44](https://github.com/LazyVim/LazyVim/issues/44) ([87c37f2](https://github.com/LazyVim/LazyVim/commit/87c37f287b609f9fba12d2a6a518823d438bac44))
* **neodev:** use opts instead of config ([7a68907](https://github.com/LazyVim/LazyVim/commit/7a68907b39cdf8a183f3e7fd0669c57637b00d7d))
* **options:** set options with `vim.set_global` ([d568098](https://github.com/LazyVim/LazyVim/commit/d56809837426ad410df53f23f12d4240b715a077))
* **options:** use `vim.opt` and trigger Lazy ui reload when needed. Fixes [#38](https://github.com/LazyVim/LazyVim/issues/38) ([e405023](https://github.com/LazyVim/LazyVim/commit/e405023530f869e8eaaa1a293806aa73ec6f453c))
* **plugins:** fix the laziness of all plugins to still work as intended with `config.defaults.lazy = false`. Fixes [#67](https://github.com/LazyVim/LazyVim/issues/67) ([6a3f3d3](https://github.com/LazyVim/LazyVim/commit/6a3f3d3032181dae5fab36b5acc9ea5da086e7fa))
* **telescope:** highlights are now under `&lt;leader&gt;sH`. [#50](https://github.com/LazyVim/LazyVim/issues/50) ([c6b83a8](https://github.com/LazyVim/LazyVim/commit/c6b83a82bf27309a16d8387d71317b062574e59e))
* **typescipt:** properly check client.name in on_attach ([cce3129](https://github.com/LazyVim/LazyVim/commit/cce3129e995fa349002c518a7655bac3fb23a395))
* **typescript:** only set ts keymaps for tsserver ([2128bf3](https://github.com/LazyVim/LazyVim/commit/2128bf3e20cceaf6c77275151087dd7606a9c15c))
* **util:** prevent loop for now. Still need to figure out what's causing it ([bbb59d3](https://github.com/LazyVim/LazyVim/commit/bbb59d3ffda8fa211f48d9791447c6a87ec5f157))
* **util:** proper fix for lazy notify ([83d18db](https://github.com/LazyVim/LazyVim/commit/83d18dbcee2af8cacbb6861e574f5f393d630618))


### Performance Improvements

* **neodev:** enable experimental pathStrict setting for better sumneko performance ([6cf6959](https://github.com/LazyVim/LazyVim/commit/6cf69592540030ee9df9a75a1221be978b63ebf0))


### Code Refactoring

* **keymaps:** terminal keymaps are now under `&lt;leader&gt;ft` and `<leader>fT` ([0cfc15e](https://github.com/LazyVim/LazyVim/commit/0cfc15e739c81e8ae4a34f6e9cf9e759e660e262))
* **neotree:** keymaps are now under `&lt;leader&gt;fe` and `<leader>fE` ([24923ed](https://github.com/LazyVim/LazyVim/commit/24923ed31ad4c019b68583cce2acdc65dd839897))
* **noice:** noice keymaps are now under `&lt;leader&gt;sn` ([f8b77db](https://github.com/LazyVim/LazyVim/commit/f8b77db51bef962f385ccd1303382582c0850764))
* **telescope:** moved most `help` keymaps under `&lt;leader&gt;s` (search) ([f32ebb9](https://github.com/LazyVim/LazyVim/commit/f32ebb918289607617529f3889a44ee657b641f0))

## 0.1.0-alpha (2023-01-09)


### ⚠ BREAKING CHANGES

* **plugins:** plugins now use lazy.nvim's new `opts` property to make it far easier to override options
* **init:** disable init.lua and show a message on how to use LazyVim
* **lsp:** move servers to lspconfig plugin spec
* **keymaps:** switching buffers now uses shift + hl keys
* **keymaps:** resizing windows now uses ctrl + arrow keys
* **keymaps:** move to window now uses ctrl hjkl
* **lps:** move signature help from `<-k>` to `gK`

### Features

* added leap and flit ([e98381a](https://github.com/LazyVim/LazyVim/commit/e98381a45abcecc0a0c3e330e6316fad8d7eceb6))
* added mini.ai for better text objects ([9907695](https://github.com/LazyVim/LazyVim/commit/9907695320d7a4dae4ab1a255217c70569290e3f))
* added mini.indentscope ([04b772e](https://github.com/LazyVim/LazyVim/commit/04b772e3e4e7167899587d587e3ab0fab04b9846))
* added mini.surround ([2fe5053](https://github.com/LazyVim/LazyVim/commit/2fe505328422c4c4c8a6cc55968751291fe104b5))
* added persistence ([ece9533](https://github.com/LazyVim/LazyVim/commit/ece95332060fb54490b625d66ba724655f49a973))
* added todo-comments ([aa74156](https://github.com/LazyVim/LazyVim/commit/aa74156dfc31166a4b1861a574aafc025ce7bb78))
* added trouble ([7280d59](https://github.com/LazyVim/LazyVim/commit/7280d593551f7b751ada5ac6003c351e785bf605))
* **alpha:** added lazy shortcut ([1467c90](https://github.com/LazyVim/LazyVim/commit/1467c900ac001e14a705275e2b4743f14b7ff8c4))
* **alpha:** added shortcut to restore session ([62dc892](https://github.com/LazyVim/LazyVim/commit/62dc892d8ecfe0805a915fcc50d46dc2cc73e238))
* **alpha:** improved colors ([0266bb8](https://github.com/LazyVim/LazyVim/commit/0266bb851d71153a73afde806f2f04468104ccfd))
* **alpha:** load on VimEnter so we can track its performance ([93c5f84](https://github.com/LazyVim/LazyVim/commit/93c5f84ebc9c81099e7e0853436ebda4c859bd23))
* **autocmds:** checktime on TermLeave and TermClose ([ff777b5](https://github.com/LazyVim/LazyVim/commit/ff777b5efd2556b02aaec8f72c0ed1cef4482dd5))
* **autocmds:** set spell and wrap for markdown ([8174821](https://github.com/LazyVim/LazyVim/commit/8174821b71a8fd0d87e6cdee517283c3aa37ad26))
* **bufferline:** added siagnostic icons ([7b9d409](https://github.com/LazyVim/LazyVim/commit/7b9d409c2f16f424ebb314e7120078b0606a1f59))
* **cmp:** added cmp-emoji ([0624811](https://github.com/LazyVim/LazyVim/commit/0624811b3bbed077a5e89ed60f0d6bdb5826a490))
* **cmp:** added kind icons ([79a6992](https://github.com/LazyVim/LazyVim/commit/79a6992676d6caa59c12ca75a87f361ce15480f1))
* **cmp:** better tab behavior for cmp and luasnip ([7753a46](https://github.com/LazyVim/LazyVim/commit/7753a46a6b7c6ef7e906a0a10f798e530b1a3f9a))
* **cmp:** ghost text ([2abd569](https://github.com/LazyVim/LazyVim/commit/2abd569ff21fe14cb65a7161e11d6d10965d904f))
* **diagnostics:** added icons ([8834510](https://github.com/LazyVim/LazyVim/commit/8834510d40a5b5eac507ccfe51905cd007d02b17))
* **editor:** added mini.bufremove ([3429ad8](https://github.com/LazyVim/LazyVim/commit/3429ad877b85885782eb1762af98d64a5a01d409))
* **git:** added lazygit ([8d43dde](https://github.com/LazyVim/LazyVim/commit/8d43ddec9b208a217f84783915714c8f5bd0a10e))
* **gitsigns:** added gitsigns keymaps ([31ddf90](https://github.com/LazyVim/LazyVim/commit/31ddf90be978f3549dd32f12776b5bc7492d1f91))
* **illuminate:** added illuminate ([b267e33](https://github.com/LazyVim/LazyVim/commit/b267e33810941d4be4fdd6d531ead2032f2fb64f))
* **indent-blankline:** better defaults ([2d442fc](https://github.com/LazyVim/LazyVim/commit/2d442fcf3951925ed24dba1f0a1cd1954f40bbdb))
* **init:** disable init.lua and show a message on how to use LazyVim ([aa6ba29](https://github.com/LazyVim/LazyVim/commit/aa6ba297722b20fd47f713d1885f7902157ddd36))
* initial commit ([58e5dae](https://github.com/LazyVim/LazyVim/commit/58e5dae036602c47521ca311b613d7c400005416))
* **keymaps:** added floating terminal ([18756a6](https://github.com/LazyVim/LazyVim/commit/18756a614c629cf5296a973747df0e2b9103a221))
* **keymaps:** added keymaps for lazygit, new file and vim.show_pos ([fd47b5d](https://github.com/LazyVim/LazyVim/commit/fd47b5d5f02b26ee4ccce534320b24ade722691a))
* **keymaps:** added missing descriptions ([838bff1](https://github.com/LazyVim/LazyVim/commit/838bff12b66365d5845f893bcdefedb2aa0d9c4e))
* **keymaps:** added missing descriptions ([38be716](https://github.com/LazyVim/LazyVim/commit/38be71692fd586ebaa8e16d5bab5e5b2dd47ce75))
* **keymaps:** added more keymaps ([47fa58c](https://github.com/LazyVim/LazyVim/commit/47fa58c2ed2c8c892703445f5e0e44c326f6f20a))
* **keymaps:** added toggle for diagnostics and conceal ([77672ba](https://github.com/LazyVim/LazyVim/commit/77672ba3fd401b84d62a93640691acc7ee9b3157))
* **keymaps:** better jk ([6824254](https://github.com/LazyVim/LazyVim/commit/68242540cffb154387c1ddafc555bfe87a56179c))
* **keymaps:** more keymaps ([df6f2fc](https://github.com/LazyVim/LazyVim/commit/df6f2fc92f6583a1fa3b1f2b3bc666f7ab473df0))
* **keymaps:** move to window now uses ctrl hjkl ([00ec5a9](https://github.com/LazyVim/LazyVim/commit/00ec5a9a3681214510acd652bda407b658cc6ee7))
* **keymaps:** resizing windows now uses ctrl + arrow keys ([ffe606e](https://github.com/LazyVim/LazyVim/commit/ffe606ee413d0bed8ca9eb4c31ba562ca86c7eb9))
* **keymaps:** switching buffers now uses shift + hl keys ([8f78270](https://github.com/LazyVim/LazyVim/commit/8f782709d8995e80e7c5560bee792b5bf590499d))
* **keymaps:** use regular jk when specifying a count ([6bfba2d](https://github.com/LazyVim/LazyVim/commit/6bfba2d66981baebbdee35628a24c1d98f2f5b5d))
* **lang:** added json support ([011356e](https://github.com/LazyVim/LazyVim/commit/011356e70e99c473157ef970675c1f0b8039e78e))
* **lazy:** use lazy.nvim HEAD for now till this repo is more stable ([305328f](https://github.com/LazyVim/LazyVim/commit/305328f3c36a9e208a8d0309a3c5b35bb753c3e4))
* **lps:** move signature help from `&lt;-k&gt;` to `gK` ([92c22d7](https://github.com/LazyVim/LazyVim/commit/92c22d793283e44b0cec66470d656ee2b6dfc519))
* **lsp:** allow for custom lsp server setup ([9fd2130](https://github.com/LazyVim/LazyVim/commit/9fd21306fcb43ea946a3d257e3656a07ebed430a))
* **lspconfig:** better setup with mason-lspconfig.setup_handlers ([12dacc4](https://github.com/LazyVim/LazyVim/commit/12dacc4d32ad815e8b2c9e19a17744f1d390eaa0))
* **lualine:** better lualine with git status, diagnostics and navic lsp information ([#15](https://github.com/LazyVim/LazyVim/issues/15)) ([d74759d](https://github.com/LazyVim/LazyVim/commit/d74759de763f74298f7966168ef90514ee117f75))
* **lualine:** better lualine with lazy.nvim updates and some noice components ([7306952](https://github.com/LazyVim/LazyVim/commit/7306952f807309d66fd93e37aaf3c00ad098a570))
* **lualine:** enabled globalstatus ([f4f2107](https://github.com/LazyVim/LazyVim/commit/f4f210732938d9005b8fac478236b551d70bc064))
* **mason:** added keymap ([0e6b710](https://github.com/LazyVim/LazyVim/commit/0e6b710627c2c297b91437fdb2b3b07a3cad30ae))
* **mason:** you can now supply a list of tools you want to have installed ([5daf0cb](https://github.com/LazyVim/LazyVim/commit/5daf0cbe7315382480a12eee05d15a02f2b66516))
* **neo-tree:** use util.get_root when opening neo-tree ([c525020](https://github.com/LazyVim/LazyVim/commit/c525020c67b06b91b0f2b155d217634efe495e7c))
* **notify:** added keymap to dismiss all notifications ([79bb9e1](https://github.com/LazyVim/LazyVim/commit/79bb9e17da13da291dc2a210df4a1b17be1bd8f7))
* **notify:** better defaults ([bbd0a8a](https://github.com/LazyVim/LazyVim/commit/bbd0a8a414523b4839ea01f3a647eac23c7b85d5))
* **options:** winminwidth ([4c2ac6b](https://github.com/LazyVim/LazyVim/commit/4c2ac6b7bfe5e39dc70b558c3ed4e3e0f84c8bab))
* **settings:** better default icons ([e42337f](https://github.com/LazyVim/LazyVim/commit/e42337f02ab5988666513a495f7c1ba8bc0254ed))
* **spectre:** search and replace in multiple files ([377a1e7](https://github.com/LazyVim/LazyVim/commit/377a1e7407fc1b3a80369a4e765f10c1194e3554))
* **startuptime:** better defaults ([d4a4822](https://github.com/LazyVim/LazyVim/commit/d4a48226dab3632f88bedc34a92f26637cc21574))
* **telescope:** added a gazillian mappings for Telescope ([9b5dd50](https://github.com/LazyVim/LazyVim/commit/9b5dd50837d64d2ca71cb9e0868a3aece3c8e4a0))
* **telescope:** added more mappings ([bce0744](https://github.com/LazyVim/LazyVim/commit/bce0744ca37e3ab82cd4d12758830b9c1bb4e8d3))
* **telescope:** better defaults ([e7c5d8a](https://github.com/LazyVim/LazyVim/commit/e7c5d8a47071cd0fa14280bc8543b90c2d75f85e))
* **telescope:** use git_files or find_files for `files` ([531f8ba](https://github.com/LazyVim/LazyVim/commit/531f8baf5e837236c42daae190d9b3361c3f1c31))
* **terminal:** double escape to enter normal mode ([454df99](https://github.com/LazyVim/LazyVim/commit/454df99ff395d3c358ad19935b5de2b5ec4ff6e5))
* **treesitter:** don't use auto_install. Use `ensure_installed` instead ([2309580](https://github.com/LazyVim/LazyVim/commit/2309580180f9e2a9f8b1eab12ef6d0f15dff5f8a))
* **typescript:** added extras for typescript ([6c73e77](https://github.com/LazyVim/LazyVim/commit/6c73e775cfc8e23cbe2bb43873933458383804c5))
* **ui:** added noice ([17c0eb4](https://github.com/LazyVim/LazyVim/commit/17c0eb4d56f1edc4643576e41086f15853d06cf1))
* **util:** added vim-startuptime ([cde9070](https://github.com/LazyVim/LazyVim/commit/cde90703b34d1117d675e3d02e5c7d431efd37a1))
* **util:** float_term using lazy's API ([08e6a88](https://github.com/LazyVim/LazyVim/commit/08e6a880f51114a2c8b48e0541256716bd20d608))
* **util:** telescope helper ([b62655f](https://github.com/LazyVim/LazyVim/commit/b62655f0b94315bd80c87585bb7b5101740a7187))
* **util:** util.get_root ([7750887](https://github.com/LazyVim/LazyVim/commit/77508877031659673356dc9423a285351045388a))
* **util:** util.on_attach ([e6dfed5](https://github.com/LazyVim/LazyVim/commit/e6dfed58f7638e07eed9619a619fabf8fbeb4cd0))
* **which-key:** added more group names ([91a2a25](https://github.com/LazyVim/LazyVim/commit/91a2a255247e5cff2fbba95d77aaaf20b20c1d02))
* **which-key:** added more group names ([725bf0d](https://github.com/LazyVim/LazyVim/commit/725bf0d00ea0cd1527e1ab008ade6bd2584771f8))
* **which-key:** defined some groups ([772fa5a](https://github.com/LazyVim/LazyVim/commit/772fa5aaa69f759d5896434965fb73834bde6e4b))


### Bug Fixes

* **alpha:** make alpha and lazy ui behave with each other ([aae683f](https://github.com/LazyVim/LazyVim/commit/aae683f868ee856acd0fd9b42e33382f317e1488))
* **alpha:** make sure alpha renders when Lazy is open after installing missing plugins ([670daaa](https://github.com/LazyVim/LazyVim/commit/670daaadc38daf801e59a516e8f76a17e90e526b))
* **autocmds:** better way of opening file at last location ([63bea54](https://github.com/LazyVim/LazyVim/commit/63bea54be2391facf20921b6c52c41f2b625794e))
* **autoformat:** make buf part of the autocmd group name ([1bc0299](https://github.com/LazyVim/LazyVim/commit/1bc029969e4376d88ff5def1594b1ff106728706))
* **cmp:** preselect entries ([276c461](https://github.com/LazyVim/LazyVim/commit/276c46107ea32b0110f938a497ac133c766a656d))
* dont disable any builtins ([016bda6](https://github.com/LazyVim/LazyVim/commit/016bda67f2f78d758ad6d66400bf4c964d04644e))
* **editor:** gitsigns prev/next hunk keymap ([#26](https://github.com/LazyVim/LazyVim/issues/26)) ([a0fadd6](https://github.com/LazyVim/LazyVim/commit/a0fadd6a11addb1f51bc2142fbd2606ec59dbc79))
* **editor:** typo and consistency ([#12](https://github.com/LazyVim/LazyVim/issues/12)) ([5bf59a6](https://github.com/LazyVim/LazyVim/commit/5bf59a6e83f4abfd0b725979a3c8a858216c4958))
* fixed highlight on yank ([d736cf4](https://github.com/LazyVim/LazyVim/commit/d736cf453e70a76ccf3a176841a6add415fc5919))
* **indentscope:** added extra filetypes to exclude ([a893251](https://github.com/LazyVim/LazyVim/commit/a893251079f882f47956773eadb9b38fd81d5d12))
* **indentscope:** Turn off indentscope in Mason ([#16](https://github.com/LazyVim/LazyVim/issues/16)) ([694c109](https://github.com/LazyVim/LazyVim/commit/694c1096d02faf21ef24c0b178f04b3d6f68858c))
* **keymaps:** only add vim.show_pos on nightly. Fixes [#10](https://github.com/LazyVim/LazyVim/issues/10) ([3d998cb](https://github.com/LazyVim/LazyVim/commit/3d998cbdb1200a6f840524781fe400b99c57bdff))
* **keymaps:** use update instead of write when saving. Fixes [#9](https://github.com/LazyVim/LazyVim/issues/9) ([825e7cd](https://github.com/LazyVim/LazyVim/commit/825e7cde3d152c66717e3f6bac832c02985d5431))
* lazxy bootstrap code checked lazypath twice ([7261a79](https://github.com/LazyVim/LazyVim/commit/7261a792a9d0381891938fa869b6a6b27c2e8f58))
* **leap:** force setting keymaps for leap to make gs work ([ad83302](https://github.com/LazyVim/LazyVim/commit/ad8330208e5622a7d983524cb542caf486f2ddaf))
* load mini.pairs ([63609e6](https://github.com/LazyVim/LazyVim/commit/63609e6764eaff5343dbb5046634e49ad8f47b22))
* **luasnip:** fixed luasnip keymaps ([05ec629](https://github.com/LazyVim/LazyVim/commit/05ec629d7b6e7d8ffdf911200dee2135ca57c498))
* **luasnips:** better defaults for &lt;tab&gt; behavior ([41645fd](https://github.com/LazyVim/LazyVim/commit/41645fdb2f67d3e870dbc676525eae620cd8af5f))
* **mini:** dont use version for indentscope and starter for now till 0.7.0 is released ([4f02877](https://github.com/LazyVim/LazyVim/commit/4f0287793dff65d871cadfb35d891ed89458b692))
* **options:** only set splitkeep on Neovim 0.9.0 ([3b700fc](https://github.com/LazyVim/LazyVim/commit/3b700fc28c3942c608188b8e2ca4aa420f984132))
* **persistence:** fixed stop session keymap description ([9026668](https://github.com/LazyVim/LazyVim/commit/9026668f2fb7fbb2e180eb638ef022124ff554d4))
* provide LSP server name in setup function ([#21](https://github.com/LazyVim/LazyVim/issues/21)) ([037d0e8](https://github.com/LazyVim/LazyVim/commit/037d0e87b306ff003fbb486248a32b274c716d97))
* **save:** change to write again to trigger auto-formatting ([259c3a6](https://github.com/LazyVim/LazyVim/commit/259c3a6612600c3bf552121db6e0b70c822c100b))
* **telescope:** always create a new opts object to prevent caching ([d224aea](https://github.com/LazyVim/LazyVim/commit/d224aea4a4a8d7fe508eeded0d16f6490ca5adc1))
* **util:** added space in msg when toggling ([5363152](https://github.com/LazyVim/LazyVim/commit/53631526ad49f64f139cc694495b27a26c301e1c))
* **which-key:** set group names for `n` and `v` ([81146e2](https://github.com/LazyVim/LazyVim/commit/81146e24457c74f654d3da95061df7b15aef1809))


### Performance Improvements

* disable some builtin plugins that are replaced by another plugin ([0d02dec](https://github.com/LazyVim/LazyVim/commit/0d02dec9d2a202014d2dcb7617653146535b565b))
* **dressing:** lazy-load on vim.ui function call ([4d2327d](https://github.com/LazyVim/LazyVim/commit/4d2327dd1ab285d8a3fef2fc3d0a9cbe7d31f433))
* lazy-load nvim-notify ([108c471](https://github.com/LazyVim/LazyVim/commit/108c471ab536358bfd53e3f48a8d3783b0d69515))
* load keymaps and autocmds on VeryLazy ([6dd32b5](https://github.com/LazyVim/LazyVim/commit/6dd32b53e534772e8b572082a4a9c2e7f1e6e1bd))
* setup which-key inside `config()` and load autocmds and keymaps as normal ([478f75c](https://github.com/LazyVim/LazyVim/commit/478f75cb76896925b2f6cda9f33a82fc18ea1072))
* **tokyonight:** use tokyonight api to load colorscheme on startup ([75d8aff](https://github.com/LazyVim/LazyVim/commit/75d8aff9799bd7f7fb390419fa1a5eb20d7cc2fd))


### Code Refactoring

* **lsp:** move servers to lspconfig plugin spec ([ef78153](https://github.com/LazyVim/LazyVim/commit/ef78153afa30fd067eff9cfda7c63c83b1379a51))
* **plugins:** plugins now use lazy.nvim's new `opts` property to make it far easier to override options ([2135bc1](https://github.com/LazyVim/LazyVim/commit/2135bc144c0ea18d550d40c38125e5cd73965c73))
