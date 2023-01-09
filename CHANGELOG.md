# Changelog

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
