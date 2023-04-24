# Changelog

## [2.12.0](https://github.com/LazyVim/LazyVim/compare/v2.11.0...v2.12.0) (2023-04-24)


### Features

* **bufferline:** use `mini.bufremove` to close a buffer ([#670](https://github.com/LazyVim/LazyVim/issues/670)) ([3e46dd6](https://github.com/LazyVim/LazyVim/commit/3e46dd61cdc79bbb915f81e4188fc5337cd2f84b))
* **telescope:** added keymap for recent files in the current directory. ([#669](https://github.com/LazyVim/LazyVim/issues/669)) ([6c334fe](https://github.com/LazyVim/LazyVim/commit/6c334fed6a59f6b1dc3a38f6253f2b4265557f30))


### Bug Fixes

* **spectre:** use new url by default ([7b9145c](https://github.com/LazyVim/LazyVim/commit/7b9145c12d15a81e40a721974a9a68994ccd8855))

## [2.11.0](https://github.com/LazyVim/LazyVim/compare/v2.10.0...v2.11.0) (2023-04-23)


### Features

* **dap:** Change DAP REPL binding from open to toggle ([#663](https://github.com/LazyVim/LazyVim/issues/663)) ([3a718c5](https://github.com/LazyVim/LazyVim/commit/3a718c5c85e966e2751dade0006dcbeed72e8b00))
* **lsp:** automatically resolve denols/tsserver conflicts if both are configured ([d565684](https://github.com/LazyVim/LazyVim/commit/d565684ade6e04eb77319ddb5becac9c5bd21cc4))
* **plugins:** automatically handle plugin repo renames ([59f3b3e](https://github.com/LazyVim/LazyVim/commit/59f3b3e096280629a459054bc5538c058854dffc))


### Bug Fixes

* **health:** remove deprecated api warning ([#666](https://github.com/LazyVim/LazyVim/issues/666)) ([4fbb7a2](https://github.com/LazyVim/LazyVim/commit/4fbb7a280310a6ea500509aa73a4f7c7d06f6bea))

## [2.10.0](https://github.com/LazyVim/LazyVim/compare/v2.9.0...v2.10.0) (2023-04-21)


### Features

* **neo-tree:** refresh neotree git status when closing a lazygit terminal ([ad214af](https://github.com/LazyVim/LazyVim/commit/ad214af54d47e67aa8be46ae12cbe7c71da0c0bf))


### Bug Fixes

* **copilot:** re-enable copilot confirm with overwrite ([40983a3](https://github.com/LazyVim/LazyVim/commit/40983a326952e24512f0eacc5b524337044ed3ff))

## [2.9.0](https://github.com/LazyVim/LazyVim/compare/v2.8.0...v2.9.0) (2023-04-21)


### Features

* **tsserver:** set some tsserver formatting settings to their Neovim equivalents. Also used for organize imports ([eb92903](https://github.com/LazyVim/LazyVim/commit/eb92903342a7ac12185c62bb63b5caa4c80ce7dc))


### Bug Fixes

* **copilot:** work-around Neovim bug. Fixes [#656](https://github.com/LazyVim/LazyVim/issues/656) ([4379ae8](https://github.com/LazyVim/LazyVim/commit/4379ae8ab9aec497e58eeae733a0a87c70289570))

## [2.8.0](https://github.com/LazyVim/LazyVim/compare/v2.7.0...v2.8.0) (2023-04-21)


### Features

* **copilot:** better copilot status colors for lualine ([1274310](https://github.com/LazyVim/LazyVim/commit/1274310e6da0de56da92ae8e26c8f388cf314a5b))


### Bug Fixes

* remove unintentional `&lt;lt&gt;nop>` mapping ([#651](https://github.com/LazyVim/LazyVim/issues/651)) ([14e708a](https://github.com/LazyVim/LazyVim/commit/14e708a24642cf3926b9b74743c192c3b5c63f3e))

## [2.7.0](https://github.com/LazyVim/LazyVim/compare/v2.6.0...v2.7.0) (2023-04-21)


### Features

* **copilot:** added lualine component for copilot. Simple icon colored by status. Will add status message when available (warnings) ([d63c471](https://github.com/LazyVim/LazyVim/commit/d63c4710083cd2bcab104972bd4a6b3d1b80c3c6))

## [2.6.0](https://github.com/LazyVim/LazyVim/compare/v2.5.0...v2.6.0) (2023-04-20)


### Features

* **extras:** added project management ([#300](https://github.com/LazyVim/LazyVim/issues/300)) ([7fe0d5c](https://github.com/LazyVim/LazyVim/commit/7fe0d5c7c798e2a1d6abf7d43380876a268ac462))


### Bug Fixes

* **project:** load on VeryLazy otherwise projects wont be loaded when opening Telescope ([5264909](https://github.com/LazyVim/LazyVim/commit/5264909b542da1c6215e042c62903bb491a2c1eb))

## [2.5.0](https://github.com/LazyVim/LazyVim/compare/v2.4.3...v2.5.0) (2023-04-19)


### Features

* **lsp:** added support for setting global lsp client capabilities ([ac10516](https://github.com/LazyVim/LazyVim/commit/ac1051686bcff8377f1d99228bcbe64530ec384a))

## [2.4.3](https://github.com/LazyVim/LazyVim/compare/v2.4.2...v2.4.3) (2023-04-19)


### Bug Fixes

* **treesitter:** de-duplicate langs in endure_installed. Fixes [#628](https://github.com/LazyVim/LazyVim/issues/628) ([1d2c97c](https://github.com/LazyVim/LazyVim/commit/1d2c97cbda099c76ee132ee5019a3f80fd88f8ed))

## [2.4.2](https://github.com/LazyVim/LazyVim/compare/v2.4.1...v2.4.2) (2023-04-19)


### Bug Fixes

* **diagnostics:** deepcopy diagnostic params. Fixes [#621](https://github.com/LazyVim/LazyVim/issues/621) ([1caa27b](https://github.com/LazyVim/LazyVim/commit/1caa27ba4acb04ebbc64a91de242574790dcf92f))

## [2.4.1](https://github.com/LazyVim/LazyVim/compare/v2.4.0...v2.4.1) (2023-04-19)


### Bug Fixes

* **lsp:** properly check that diagnostics virtual_text is a table. Fixes [#618](https://github.com/LazyVim/LazyVim/issues/618) ([17fe32e](https://github.com/LazyVim/LazyVim/commit/17fe32e428bbade6f91770814e8748425bfc01a2))

## [2.4.0](https://github.com/LazyVim/LazyVim/compare/v2.3.0...v2.4.0) (2023-04-18)


### Features

* **dap:** add more keybindings and lualine component ([#612](https://github.com/LazyVim/LazyVim/issues/612)) ([38ad79d](https://github.com/LazyVim/LazyVim/commit/38ad79d5485c083afdb04b1fb9f9683403a6d7bd))
* **diagnostics:** added support for setting prefix = "icons". Check the docs on how to enable ([01a1b8e](https://github.com/LazyVim/LazyVim/commit/01a1b8e80db55963f281cf36674cf1c174e2f50e))
* **diagnostics:** show diagnostics source when more than one source is reporting diagnostics ([06c38c5](https://github.com/LazyVim/LazyVim/commit/06c38c52a91bb1dcc2dec2d79d6e13606324be77))

## [2.3.0](https://github.com/LazyVim/LazyVim/compare/v2.2.1...v2.3.0) (2023-04-17)


### Features

* **dap:** add step out, rebind step over ([#605](https://github.com/LazyVim/LazyVim/issues/605)) ([cfaf3b0](https://github.com/LazyVim/LazyVim/commit/cfaf3b054e1a68ea0f7a73d51a0f6c27395198e9))

## [2.2.1](https://github.com/LazyVim/LazyVim/compare/v2.2.0...v2.2.1) (2023-04-17)


### Bug Fixes

* **telescope:** typo ([a94f7af](https://github.com/LazyVim/LazyVim/commit/a94f7afdebc56338b5552de11561646d8ef4b5be))

## [2.2.0](https://github.com/LazyVim/LazyVim/compare/v2.1.0...v2.2.0) (2023-04-17)


### Features

* **noice:** added keymap to dismiss all noice messages ([0155de0](https://github.com/LazyVim/LazyVim/commit/0155de00ab76e7ffc1d8232c10121f24c4e84cd9))


### Bug Fixes

* **lsp:** gT =&gt; gy. keymap for goto type definition. Fixes [#554](https://github.com/LazyVim/LazyVim/issues/554) ([0cb8974](https://github.com/LazyVim/LazyVim/commit/0cb89742216d4c73fa944ab9e2fcd21793ed7a78))
* **telescope:** consistent keymap description. Fixes [#600](https://github.com/LazyVim/LazyVim/issues/600) ([df9547f](https://github.com/LazyVim/LazyVim/commit/df9547f43223fd89ccc7c1fa5088623ca3c2cfd4))

## [2.1.0](https://github.com/LazyVim/LazyVim/compare/v2.0.0...v2.1.0) (2023-04-16)


### Features

* added extra for dap ([bc14e02](https://github.com/LazyVim/LazyVim/commit/bc14e02a1ff43f1a69d2a6755faeec8a5ec26ac9))
* **dap:** added extra for dap nlua ([f562d1d](https://github.com/LazyVim/LazyVim/commit/f562d1d19761c3419380c3b175fd00a440ff0932))
* **which-key:** easier integration for which-key group names ([df94a04](https://github.com/LazyVim/LazyVim/commit/df94a044ec656c456067b550531a62e80a5be420))


### Bug Fixes

* **dap:** added DapInstall and DapUninstall to cmds ([feaeab9](https://github.com/LazyVim/LazyVim/commit/feaeab9fcabf005cbf18b846d2ab0129a73837a9))

## [2.0.0](https://github.com/LazyVim/LazyVim/compare/v1.24.0...v2.0.0) (2023-04-16)


### ⚠ BREAKING CHANGES

* **treesitter:** rename help to vimdoc ([#521](https://github.com/LazyVim/LazyVim/issues/521))

### Features

* **autocmds:** add checkhealth filetype to close_with_q list ([#512](https://github.com/LazyVim/LazyVim/issues/512)) ([1defd5f](https://github.com/LazyVim/LazyVim/commit/1defd5f67008c695a7d99d72bc50432de5eaed3a))
* **keymaps:** Get rename command from inc_rename configuration ([#579](https://github.com/LazyVim/LazyVim/issues/579)) ([a099b2d](https://github.com/LazyVim/LazyVim/commit/a099b2d3ab3ff3bafb075c101e2b2a48b44fe869))
* **telescope:** add document/workspace diagnostics and todo/fixme telescope keymaps ([#557](https://github.com/LazyVim/LazyVim/issues/557)) ([98775f5](https://github.com/LazyVim/LazyVim/commit/98775f56312110c640be7e9d43ecc766a116427a))
* **telescope:** use the new dynamic workspace symbols ([#577](https://github.com/LazyVim/LazyVim/issues/577)) ([6e01e85](https://github.com/LazyVim/LazyVim/commit/6e01e8560e4ca197bc56666e9b969fe75d91b310))


### Bug Fixes

* **autocmds:** don't auto create dirs for urls. Fixes [#583](https://github.com/LazyVim/LazyVim/issues/583) ([7476da7](https://github.com/LazyVim/LazyVim/commit/7476da78117b032bc34d0130e6b1f9c7eea77073))
* **config:** options cant be disabled with lazyvim config. Fixes [#566](https://github.com/LazyVim/LazyVim/issues/566) ([02c5e8d](https://github.com/LazyVim/LazyVim/commit/02c5e8d953fff68b832a8f22a83428bd229ddc59))
* **format:** ignore vim.b.autoformat when formatting using key bindings. Fixes [#575](https://github.com/LazyVim/LazyVim/issues/575) ([bef36bb](https://github.com/LazyVim/LazyVim/commit/bef36bb2fd7493828529ed49a071d240602b164d))
* **lazygit:** dont use `&lt;esc&gt;<esc>` for normal more for laygit to prevent delays on `<esc>`. Fixes [#567](https://github.com/LazyVim/LazyVim/issues/567) ([a9e9204](https://github.com/LazyVim/LazyVim/commit/a9e9204daec3355015bbe677068198cf38cd2cf3))
* **lsp:** gt -&gt; gT. Fixes [#554](https://github.com/LazyVim/LazyVim/issues/554) ([2d8116e](https://github.com/LazyVim/LazyVim/commit/2d8116ef674ad4b2a3ba62f590ff32d1c30a2f9c))


### Code Refactoring

* **treesitter:** rename help to vimdoc ([#521](https://github.com/LazyVim/LazyVim/issues/521)) ([078250a](https://github.com/LazyVim/LazyVim/commit/078250a114b45785743fcfe0482c7667f304f92c))

## [1.24.0](https://github.com/LazyVim/LazyVim/compare/v1.23.0...v1.24.0) (2023-03-31)


### Features

* **autocmds:** add auto create dir ([#493](https://github.com/LazyVim/LazyVim/issues/493)) ([ed48b85](https://github.com/LazyVim/LazyVim/commit/ed48b85dbea30a15518b4caa58cbf5d2b54f97a0))
* **lualine:** added lazy extension ([79fe045](https://github.com/LazyVim/LazyVim/commit/79fe0455a02b791eae26e9934fdbaf075d9522ae))

## [1.23.0](https://github.com/LazyVim/LazyVim/compare/v1.22.0...v1.23.0) (2023-03-25)


### Features

* **treesitter:** use Python indents as they've improved greatly ([#490](https://github.com/LazyVim/LazyVim/issues/490)) ([59eb198](https://github.com/LazyVim/LazyVim/commit/59eb19835f3b291912d46e5e8ea762367201cbf1))

## [1.22.0](https://github.com/LazyVim/LazyVim/compare/v1.21.2...v1.22.0) (2023-03-23)


### Features

* **mason:** compatibility with the new mason registry ([df5cbfd](https://github.com/LazyVim/LazyVim/commit/df5cbfdbeccfa37ee391be8b49da7a4a4b6dcc40))
* **treesitter:** add luadoc ([#469](https://github.com/LazyVim/LazyVim/issues/469)) ([ade4342](https://github.com/LazyVim/LazyVim/commit/ade4342c42c47f4eadae3e6267ac35f546692158))


### Bug Fixes

* **autocmd:** remove query from q-to-quit autocmd ([#473](https://github.com/LazyVim/LazyVim/issues/473)) ([b0cef1f](https://github.com/LazyVim/LazyVim/commit/b0cef1f506e4bbaa8cfe07990ee49518d8e13f3d))
* **mason:** removed flake8. You can add it back in your own configs if you need it or add ruff_lsp ([381ee0a](https://github.com/LazyVim/LazyVim/commit/381ee0a9fc536a4e1ed9ad3e089f10129f0d50a0))

## [1.21.2](https://github.com/LazyVim/LazyVim/compare/v1.21.1...v1.21.2) (2023-03-19)


### Bug Fixes

* **alpha:** use `AlphaFooter` highlight for footer section ([#461](https://github.com/LazyVim/LazyVim/issues/461)) ([a7b25e1](https://github.com/LazyVim/LazyVim/commit/a7b25e13fa645dea848047e0dda54db9b254ec8e))

## [1.21.1](https://github.com/LazyVim/LazyVim/compare/v1.21.0...v1.21.1) (2023-03-17)


### Bug Fixes

* **config:** compat with lazy.nvim ([501474e](https://github.com/LazyVim/LazyVim/commit/501474e42166e199e61b4e704b266bd0a9625a65))

## [1.21.0](https://github.com/LazyVim/LazyVim/compare/v1.20.0...v1.21.0) (2023-03-17)


### Features

* **lsp:** added keymap to see source actions with `&lt;leader&gt;cA` (useful for tsserver and others) ([9f5a0f1](https://github.com/LazyVim/LazyVim/commit/9f5a0f1bd847663deea9cb48a178b85d7bdb3ec6))

## [1.20.0](https://github.com/LazyVim/LazyVim/compare/v1.19.0...v1.20.0) (2023-03-17)


### Features

* **lsp:** make lsp work when mason-lspconfig is disabled. Fixed [#445](https://github.com/LazyVim/LazyVim/issues/445) ([c10e550](https://github.com/LazyVim/LazyVim/commit/c10e550639caef68146d122d9bc4a66f2f38650a))


### Bug Fixes

* **icons:** replace obsolete icons ([#441](https://github.com/LazyVim/LazyVim/issues/441)) ([cec000d](https://github.com/LazyVim/LazyVim/commit/cec000dfd863bd681a5195eb71c0797f5d030062))

## [1.19.0](https://github.com/LazyVim/LazyVim/compare/v1.18.2...v1.19.0) (2023-03-14)


### Features

* **mini-starter:** add Session restore to starter menu ([#421](https://github.com/LazyVim/LazyVim/issues/421)) ([bcdcfab](https://github.com/LazyVim/LazyVim/commit/bcdcfab020308a90c8cb347cf63d318f4cb05941))


### Bug Fixes

* **core:** set `cond=true` for LazyVim ([df6ac59](https://github.com/LazyVim/LazyVim/commit/df6ac591baf8ab2ef40e3ddcaf34ed124f42469f))

## [1.18.2](https://github.com/LazyVim/LazyVim/compare/v1.18.1...v1.18.2) (2023-03-12)


### Bug Fixes

* **lsp:** allow `silent=false` for lsp keymaps. Fixes [#414](https://github.com/LazyVim/LazyVim/issues/414) ([a28885b](https://github.com/LazyVim/LazyVim/commit/a28885be3f2428c993a3133f283d5648b6fa6b94))

## [1.18.1](https://github.com/LazyVim/LazyVim/compare/v1.18.0...v1.18.1) (2023-03-10)


### Bug Fixes

* **prettier:** extend ensure_installed instead of overwriting it. Fixes [#406](https://github.com/LazyVim/LazyVim/issues/406) ([9f30a2e](https://github.com/LazyVim/LazyVim/commit/9f30a2e03a66775bcbf3601e7a46e0aacf1bb291))

## [1.18.0](https://github.com/LazyVim/LazyVim/compare/v1.17.1...v1.18.0) (2023-03-10)


### Features

* **copilot:** better sorting for cmp sources when using copilot ([23ba877](https://github.com/LazyVim/LazyVim/commit/23ba877bb07f17a44af60e341be9f246ece5c133))
* **eslint:** added an extra for eslint lsp that runs EslintFixAll before saving a buffer ([75299da](https://github.com/LazyVim/LazyVim/commit/75299da24c4982f0d3ec6c9c3fbad7f94aa9eb72))
* **null-ls:** added .neoconf.json to null-ls root_dir ([5aad574](https://github.com/LazyVim/LazyVim/commit/5aad5749a745f928b0a1954917467f04c84e8a07))
* **null-ls:** added fish_indent and fish diag ([8f3834b](https://github.com/LazyVim/LazyVim/commit/8f3834bc13c6ca5acf82c1e44c5c250799d683a0))
* **prettierd:** added an extra for prettierd with null-ls ([aa8bae0](https://github.com/LazyVim/LazyVim/commit/aa8bae07aea7a81e2f507e1920fd84a6b83c34ad))
* **shfmt:** added shfmt to null-ls and mason ([c407ddf](https://github.com/LazyVim/LazyVim/commit/c407ddfe8ab36608ba1fe1c1d4f6723cce506a01))
* **typescript:** added null-ls typescript code actions ([5bb2314](https://github.com/LazyVim/LazyVim/commit/5bb23147877b3fcbe4cc28c0a7d820bcb52bb141))


### Bug Fixes

* **eslint:** only run EslintFixAll on buffers where eslint is attached ([f1dbd09](https://github.com/LazyVim/LazyVim/commit/f1dbd097e4461c322d6982c925d605a6ed57a4b2))

## [1.17.1](https://github.com/LazyVim/LazyVim/compare/v1.17.0...v1.17.1) (2023-03-05)


### Bug Fixes

* **copilot:** confirm with replace for copilot only ([079d396](https://github.com/LazyVim/LazyVim/commit/079d3967d03d47b95bdec10bb2621db1c4a07dce))

## [1.17.0](https://github.com/LazyVim/LazyVim/compare/v1.16.0...v1.17.0) (2023-03-05)


### Features

* add luap to nvim-treesitter ensure_installed ([#383](https://github.com/LazyVim/LazyVim/issues/383)) ([f441faa](https://github.com/LazyVim/LazyVim/commit/f441faad03501198a4a1ed52bca48aac3c7158c3))
* **autocmds:** added 'query' to close_with_q autocmd ([2e951e4](https://github.com/LazyVim/LazyVim/commit/2e951e4f4414ba88895b1ddc3a189dd3213be404))


### Bug Fixes

* **mason:** removed installing of shellcheck and shfmt. Use bashls instead ([e7a515e](https://github.com/LazyVim/LazyVim/commit/e7a515e5481e6cd2f00e8da523454713009f12a5))
* rename more appropriately (also a typo) ([#378](https://github.com/LazyVim/LazyVim/issues/378)) ([9dd2487](https://github.com/LazyVim/LazyVim/commit/9dd2487529d6012088e86f089c445549aa4b37bb))
* **typescript:** enable function call completion snippets ([6fec14e](https://github.com/LazyVim/LazyVim/commit/6fec14e5082363ab87efb169f312a396e5e2dbb7))

## [1.16.0](https://github.com/LazyVim/LazyVim/compare/v1.15.0...v1.16.0) (2023-03-03)


### Features

* **neo-tree:** added expanders ([57c2dcb](https://github.com/LazyVim/LazyVim/commit/57c2dcb3a35704a849ea8ba210f963c22fb6d1ce))

## [1.15.0](https://github.com/LazyVim/LazyVim/compare/v1.14.1...v1.15.0) (2023-03-03)


### Features

* **cmp:** added `&lt;s-CR&gt;` to confirm completion with replace ([3a52307](https://github.com/LazyVim/LazyVim/commit/3a523075057f346451075454a96b1ca355f7592a))
* **copilot:** added an extra to enable copilot. `{import = "lazyvim.plugins.extras.coding.copilot"}` ([368c65e](https://github.com/LazyVim/LazyVim/commit/368c65e14b1155d051b4aa6bac91808a2bc5f5ba))


### Bug Fixes

* **luasnip:** added note that jsregexp is optional if it fails to build ([04a60e2](https://github.com/LazyVim/LazyVim/commit/04a60e251b1c2437ad6d0a237fbacc1848d4aac1))

## [1.14.1](https://github.com/LazyVim/LazyVim/compare/v1.14.0...v1.14.1) (2023-03-02)


### Bug Fixes

* **alpha:** larger session icon. Fixes [#365](https://github.com/LazyVim/LazyVim/issues/365) ([d00aade](https://github.com/LazyVim/LazyVim/commit/d00aade8dbb7720b3f501424814ec3dd357b7373))
* **leap:** unpin leap ([16e4a3f](https://github.com/LazyVim/LazyVim/commit/16e4a3f8fd5929c9ef2cf2c12b076bcbc947ab36))
* **luasnip:** dont build jsregexp on Windows ([f6f3ce4](https://github.com/LazyVim/LazyVim/commit/f6f3ce4a9b7a797653dc290b9485d2ce970af871))

## [1.14.0](https://github.com/LazyVim/LazyVim/compare/v1.13.1...v1.14.0) (2023-03-01)


### Features

* **telescope:** Add open selected with trouble keymap ([#357](https://github.com/LazyVim/LazyVim/issues/357)) ([f9b7406](https://github.com/LazyVim/LazyVim/commit/f9b7406df96cf1fad5685865ffef5ec725573f1c))

## [1.13.1](https://github.com/LazyVim/LazyVim/compare/v1.13.0...v1.13.1) (2023-03-01)


### Bug Fixes

* **leap:** pin leap for now till flit issue is fixed ([787ceab](https://github.com/LazyVim/LazyVim/commit/787ceab0311ce20cc37ef2a81dabafdc09f1c624))

## [1.13.0](https://github.com/LazyVim/LazyVim/compare/v1.12.1...v1.13.0) (2023-02-28)


### Features

* **keymaps:** Add previous/next trouble/quickfix item keymap `[q`, `]q` ([#299](https://github.com/LazyVim/LazyVim/issues/299)) ([59fa836](https://github.com/LazyVim/LazyVim/commit/59fa83653f3d4f1911e220c2a96a7e47878a16bc))


### Bug Fixes

* **git-signs:** larger icons for delete ([4b37723](https://github.com/LazyVim/LazyVim/commit/4b37723558e45f14c3e8d05fc84ad3a701b9faf0))
* **icons:** replace obsolete Nerd icons ([#331](https://github.com/LazyVim/LazyVim/issues/331)) ([588dc5d](https://github.com/LazyVim/LazyVim/commit/588dc5dd65aa3881122aa4e59710de6722423251))
* **lsp:** only map lsp goto definition when client has definitionProvider ([#348](https://github.com/LazyVim/LazyVim/issues/348)) ([5abb10b](https://github.com/LazyVim/LazyVim/commit/5abb10b5ab3c2c5462f699fc98f618f39543f8f4))
* **luasnips:** make install_jsregexp ([bd62cbe](https://github.com/LazyVim/LazyVim/commit/bd62cbe370a72525a29790c710d3f213c3e184e4))
* **mini-indentscope:** disable indentscope for filetypes during init. Fixes [#318](https://github.com/LazyVim/LazyVim/issues/318) ([d97bf66](https://github.com/LazyVim/LazyVim/commit/d97bf66eed76c91eac11c81dad69aff9f632b214))
* **treesitter:** always install all built-in treesitter parsers to prevent queriy issues ([fc765e9](https://github.com/LazyVim/LazyVim/commit/fc765e9e3d1fe8dc9f84087a73f12a2b3bbe60c4))

## [1.12.1](https://github.com/LazyVim/LazyVim/compare/v1.12.0...v1.12.1) (2023-02-20)


### Bug Fixes

* **treesitter:** nil check [#312](https://github.com/LazyVim/LazyVim/issues/312) ([#313](https://github.com/LazyVim/LazyVim/issues/313)) ([0eef2c2](https://github.com/LazyVim/LazyVim/commit/0eef2c2f29cc95b6a3da8c9dced215acf60147dc))

## [1.12.0](https://github.com/LazyVim/LazyVim/compare/v1.11.0...v1.12.0) (2023-02-20)


### Features

* persist pinned tabs ([#304](https://github.com/LazyVim/LazyVim/issues/304)) ([6b9f0c0](https://github.com/LazyVim/LazyVim/commit/6b9f0c0c3c16b39a0764632402707822a084af50))
* **telescope:** add `&lt;leader&gt;sS` for `:Telescope lsp_workspace_symbols` ([#309](https://github.com/LazyVim/LazyVim/issues/309)) ([cccdc1c](https://github.com/LazyVim/LazyVim/commit/cccdc1cacfa486edcaf67111aa3c6fd9a626ae1f))


### Bug Fixes

* **illuminate:** always set refernce keymaps on the buffer as well to properly overwrite ftplugin mappings. Fixes [#292](https://github.com/LazyVim/LazyVim/issues/292) ([a0cf00c](https://github.com/LazyVim/LazyVim/commit/a0cf00c81b3a4a352cdc26c94112d9a5827881e1))
* **mini.surround:** don't create empty keymaps. Fixes [#296](https://github.com/LazyVim/LazyVim/issues/296) ([8e84dcf](https://github.com/LazyVim/LazyVim/commit/8e84dcf85c8a73ebcf6ade6b7b77544f468f1dfa))
* **treesitter:** disable indent only for python right now ([de6a28b](https://github.com/LazyVim/LazyVim/commit/de6a28b781e8a06e4f70c913539c97260392131a))
* **treesitter:** disable treesitter indent by default, since it has too many issues. See [#297](https://github.com/LazyVim/LazyVim/issues/297) ([329a2da](https://github.com/LazyVim/LazyVim/commit/329a2daff493abd2bd5c8fedbf0dfa13039d3931))

## [1.11.0](https://github.com/LazyVim/LazyVim/compare/v1.10.0...v1.11.0) (2023-02-17)


### Features

* **telescope:** add `&lt;leader&gt;sR` for `:Telescope resume` ([#284](https://github.com/LazyVim/LazyVim/issues/284)) ([9edd1a9](https://github.com/LazyVim/LazyVim/commit/9edd1a938f153dfa0c31c38123eabe08d931b5b2))


### Bug Fixes

* **lualine:** Add a space separator between progress & location in lualine ([#285](https://github.com/LazyVim/LazyVim/issues/285)) ([78cb3bb](https://github.com/LazyVim/LazyVim/commit/78cb3bb66d45762ba85190b2901360f683a8aa95))

## [1.10.0](https://github.com/LazyVim/LazyVim/compare/v1.9.4...v1.10.0) (2023-02-16)


### Features

* **leap:** lazy-load leap/flit and added keymaps ([eccd122](https://github.com/LazyVim/LazyVim/commit/eccd122e6dafae48bbf3c63e9fb3ae1ad4fc47a4))


### Bug Fixes

* **treesitter-textobjects:** only disable the textobject plugins/* files when its not enabled in the treesitter opts ([94ebe25](https://github.com/LazyVim/LazyVim/commit/94ebe25ccb296e4342586723acd1d35b8fda8f35))

## [1.9.4](https://github.com/LazyVim/LazyVim/compare/v1.9.3...v1.9.4) (2023-02-15)


### Bug Fixes

* **health:** also check for fdfind instead of just fd. Fixes [#270](https://github.com/LazyVim/LazyVim/issues/270) ([d198a19](https://github.com/LazyVim/LazyVim/commit/d198a193256429e401fbec7fa8ac7a46de06f07b))

## [1.9.3](https://github.com/LazyVim/LazyVim/compare/v1.9.2...v1.9.3) (2023-02-14)


### Bug Fixes

* **notify:** install notify when noice is not enabled ([5d6f0d5](https://github.com/LazyVim/LazyVim/commit/5d6f0d58d5daf2f87ea9f0a49170103925d1b528))
* **which-key:** only add noice group when noice is enabled ([38eb3bf](https://github.com/LazyVim/LazyVim/commit/38eb3bf115f1b550e853a04545932fad3fbffe5b))

## [1.9.2](https://github.com/LazyVim/LazyVim/compare/v1.9.1...v1.9.2) (2023-02-12)


### Bug Fixes

* **format:** dont format if client capaibilities disabled it. [#249](https://github.com/LazyVim/LazyVim/issues/249) ([fab6150](https://github.com/LazyVim/LazyVim/commit/fab6150da919a094614752f95f5fe4e7f55832f8))
* **format:** nil check ([a3aeb27](https://github.com/LazyVim/LazyVim/commit/a3aeb27cbc2fa1f19d525b97ebb4cc1a56c7c538))

## [1.9.1](https://github.com/LazyVim/LazyVim/compare/v1.9.0...v1.9.1) (2023-02-12)


### Bug Fixes

* **cmp:** added `&lt;c-n&gt;` and `<c-p>` to make it more consistent ([31ad893](https://github.com/LazyVim/LazyVim/commit/31ad893788e0d207a75feaccd61632cdd95b49a0))
* **lsp:** temp mason fix for sumenko_lua -&gt; lua_ls rename. See [#248](https://github.com/LazyVim/LazyVim/issues/248) ([5431268](https://github.com/LazyVim/LazyVim/commit/543126818e678509ee9e17836f0e7906146a1002))
* **telescope:** make key bindings more consistent for telescope ([151bf12](https://github.com/LazyVim/LazyVim/commit/151bf12a9f9591bd324a359374e6c4a5fb65bbbc))

## [1.9.0](https://github.com/LazyVim/LazyVim/compare/v1.8.0...v1.9.0) (2023-02-11)


### Features

* **config:** allow to disable loading of the default keymaps/autocmds/options. Fixes [#238](https://github.com/LazyVim/LazyVim/issues/238) ([6669e63](https://github.com/LazyVim/LazyVim/commit/6669e63368b88430ff574b8f392e8afb6cb434cb))

## [1.8.0](https://github.com/LazyVim/LazyVim/compare/v1.7.2...v1.8.0) (2023-02-10)


### Features

* **mini.ai:** added all mini.ai text-objects to which-key ([b96ea66](https://github.com/LazyVim/LazyVim/commit/b96ea665b3056a6a4877de8e8ae6834923a2f415))
* **telescope:** improved Telescope mappings in normal and insert mode ([#231](https://github.com/LazyVim/LazyVim/issues/231)) ([fd0a0e8](https://github.com/LazyVim/LazyVim/commit/fd0a0e829d7ea6aa8179b1d1efdf7083a4936c44))

## [1.7.2](https://github.com/LazyVim/LazyVim/compare/v1.7.1...v1.7.2) (2023-02-09)


### Bug Fixes

* **leap:** don't use the x and X mappings in visual mode ([42d2411](https://github.com/LazyVim/LazyVim/commit/42d2411bfa1d6fcc5edc20ee6dbc0dff0f0fba6e))

## [1.7.1](https://github.com/LazyVim/LazyVim/compare/v1.7.0...v1.7.1) (2023-02-09)


### Bug Fixes

* **lsp:** remove debug ([cb384ad](https://github.com/LazyVim/LazyVim/commit/cb384ad69f71e351f6441d535c7757f63a8093ba))

## [1.7.0](https://github.com/LazyVim/LazyVim/compare/v1.6.0...v1.7.0) (2023-02-09)


### Features

* **bufferline:** added keymaps to pin and delete non-pinned buffers. See [#218](https://github.com/LazyVim/LazyVim/issues/218) ([3af9155](https://github.com/LazyVim/LazyVim/commit/3af91550be67d9699567727fffcae8aabafc0898))


### Bug Fixes

* **lsp:** dont use expr=true for lsp rename. Fixes [#220](https://github.com/LazyVim/LazyVim/issues/220) ([d61e4bd](https://github.com/LazyVim/LazyVim/commit/d61e4bd553b011bb9ec8e01a2f8d2590a6bc9b5e))

## [1.6.0](https://github.com/LazyVim/LazyVim/compare/v1.5.0...v1.6.0) (2023-02-07)


### Features

* **lsp:** allow disabling autoformat for certain buffers ([52b34ce](https://github.com/LazyVim/LazyVim/commit/52b34ce3c3e486c7c3012a370651fa289e4647a0))

## [1.5.0](https://github.com/LazyVim/LazyVim/compare/v1.4.0...v1.5.0) (2023-02-07)


### Features

* **autocmds:** add groups to autocmds ([#151](https://github.com/LazyVim/LazyVim/issues/151)) ([f57031d](https://github.com/LazyVim/LazyVim/commit/f57031db7ce12ddf21c6a51a22a9370237a729b6))
* **trouble:** keymaps for trouble quicklist / loclist ([#171](https://github.com/LazyVim/LazyVim/issues/171)) ([088914e](https://github.com/LazyVim/LazyVim/commit/088914e1dd218f910586c83bdb72fe554c88a6da))


### Bug Fixes

* **plugins:** lazy-loading on BufReadPre or BufReadPost, should also use BufNewFile. Fixes [#169](https://github.com/LazyVim/LazyVim/issues/169) ([5f5a564](https://github.com/LazyVim/LazyVim/commit/5f5a564a82a8a9734012c9131f28056524366c6a))

## [1.4.0](https://github.com/LazyVim/LazyVim/compare/v1.3.4...v1.4.0) (2023-02-07)


### Features

* **icons:** add copilot icon ([#195](https://github.com/LazyVim/LazyVim/issues/195)) ([a575540](https://github.com/LazyVim/LazyVim/commit/a5755408dd7183f52188f7377bef87b949134406))


### Bug Fixes

* **keymaps:** move lines with silent and without triggering cmdline. Fixes [#184](https://github.com/LazyVim/LazyVim/issues/184) ([2ff2131](https://github.com/LazyVim/LazyVim/commit/2ff213126ceb7c85619a084f9bde4c92199248f3))
* **keymaps:** silent by default ([e5626e9](https://github.com/LazyVim/LazyVim/commit/e5626e9a2dadf9b27287fc81b2dd59bd5291f684))
* **lsp:** properly merge lsp client capabilities ([826655b](https://github.com/LazyVim/LazyVim/commit/826655b901485da4a16e0c559ba7146f566a3122))
* **mini.indent:** no need to disable indent in alpha dashboard config. Fixes [#199](https://github.com/LazyVim/LazyVim/issues/199) ([320f5c6](https://github.com/LazyVim/LazyVim/commit/320f5c6de78a8671393ef221bccc9dce8265d3e5))
* **mini.surround:** use merged plugin spec to build keys. Fixes [#172](https://github.com/LazyVim/LazyVim/issues/172). Fixes [#177](https://github.com/LazyVim/LazyVim/issues/177) ([1823236](https://github.com/LazyVim/LazyVim/commit/182323623af2f91a21285025a603be1eb329853c))
* **typescript:** typescript extras Keymaps ([#175](https://github.com/LazyVim/LazyVim/issues/175)) ([3a28ce7](https://github.com/LazyVim/LazyVim/commit/3a28ce7919b05b4bcec2fdc461eac099d0905835))

## [1.3.4](https://github.com/LazyVim/LazyVim/compare/v1.3.3...v1.3.4) (2023-02-02)


### Bug Fixes

* **mini.ai:** load ai on VeryLazy. Keymaps interfer with which-key. [#155](https://github.com/LazyVim/LazyVim/issues/155) ([3b5f363](https://github.com/LazyVim/LazyVim/commit/3b5f36307438ad05beae6796ca005f6b56d6a360))
* **noice:** scroll doc window in normal, insert and select mode ([c5b22c0](https://github.com/LazyVim/LazyVim/commit/c5b22c0832603198f571ff68b6fb9d0c17f73d33))
* **nvim-navic:** use kinds icons for navic. Fixes [#164](https://github.com/LazyVim/LazyVim/issues/164) ([b81ecf9](https://github.com/LazyVim/LazyVim/commit/b81ecf9f7ac78e3f87a4d9b305fa0d3cfd6decf2))

## [1.3.3](https://github.com/LazyVim/LazyVim/compare/v1.3.2...v1.3.3) (2023-01-29)


### Bug Fixes

* **lualine:** fixed nei-tree extension ([#132](https://github.com/LazyVim/LazyVim/issues/132)) ([835f77f](https://github.com/LazyVim/LazyVim/commit/835f77f3bebf7b189b0a120ef5fabe6a654b046d))
* **neo-tree:** disable the `&lt;space&gt;` mapping (you can use `<cr>` instead), to make sure `<leader>` mappings still work. Fixes [#146](https://github.com/LazyVim/LazyVim/issues/146) ([ac1f188](https://github.com/LazyVim/LazyVim/commit/ac1f188525b78fa78cfac8908bdbf974f8cb5ff4))
* **neo-tree:** dont change cwd when opening neo-tree. Fixes [#130](https://github.com/LazyVim/LazyVim/issues/130) ([5ac9938](https://github.com/LazyVim/LazyVim/commit/5ac9938cc8a1aac5d1c3b694900e6f67553f4de3))

## [1.3.2](https://github.com/LazyVim/LazyVim/compare/v1.3.1...v1.3.2) (2023-01-25)


### Bug Fixes

* **bufferline:** plugin was renamed from nvim-bufferline.lua -&gt; bufferline.nvim. Fixes [#128](https://github.com/LazyVim/LazyVim/issues/128) ([2ae2a63](https://github.com/LazyVim/LazyVim/commit/2ae2a6326524baef7c271c4d01f950bffe6aa755))
* **config:** don't set options to their defaults ([#120](https://github.com/LazyVim/LazyVim/issues/120)) ([8650f2c](https://github.com/LazyVim/LazyVim/commit/8650f2c99a95845bbf8037f49682f9aa75b0795d))
* **config:** return defaults when setup was not run yet. Fixes [#126](https://github.com/LazyVim/LazyVim/issues/126) ([bd4f350](https://github.com/LazyVim/LazyVim/commit/bd4f3505037ef95047d63faab959e4777462ffe4))
* **illuminate:** delete `]]` and `[[` keymaps set by ftplugins. Fixes [#124](https://github.com/LazyVim/LazyVim/issues/124) ([5a4cb1b](https://github.com/LazyVim/LazyVim/commit/5a4cb1b7eedec850f4d20ac47837a03180993987))

## [1.3.1](https://github.com/LazyVim/LazyVim/compare/v1.3.0...v1.3.1) (2023-01-24)


### Bug Fixes

* **lsp:** again ([5bf979d](https://github.com/LazyVim/LazyVim/commit/5bf979d234c5af60efb976bd56dded16823df743))
* **lsp:** check for nvim-cmp intsead of cmp ([744028e](https://github.com/LazyVim/LazyVim/commit/744028ea4c87acbb1674c20bae094fa4abca9c7d))

## [1.3.0](https://github.com/LazyVim/LazyVim/compare/v1.2.0...v1.3.0) (2023-01-24)


### Features

* added deactivate for neo-tree and noice ([10f8097](https://github.com/LazyVim/LazyVim/commit/10f809784d9d8a8eba5937ff56fe9ab8807a6832))
* **health:** added some simple health checks ([adee052](https://github.com/LazyVim/LazyVim/commit/adee0521bff6fd126163312e3693320f7aa29259))
* **keymaps:** do not create keymaps when a lazy keys handler exists ([012dbab](https://github.com/LazyVim/LazyVim/commit/012dbab586529484cfec4d1c399b621a01e4164e))


### Bug Fixes

* **lsp:** `]w` and `[w` now work as expected. Fixes [#109](https://github.com/LazyVim/LazyVim/issues/109) ([7595bfa](https://github.com/LazyVim/LazyVim/commit/7595bfaa3b35e424e54f7600588e1c134a237ef8))
* **lsp:** only load cmp-nvim-lsp when cmp is enabled ([b81dc71](https://github.com/LazyVim/LazyVim/commit/b81dc712119bc3b690028f4c0056eeacf8644037))
* **options:** don't set GUI font. Fixes [#113](https://github.com/LazyVim/LazyVim/issues/113) ([1b3b18d](https://github.com/LazyVim/LazyVim/commit/1b3b18d53bb0b6f97864c5a21fe5c3955147f7f0))
* **telescope:** bind hidden/ignore to `&lt;a-i&gt;`, `<a-h>` instead of `<c-i`> since thats the same as `<tab>`. Fixes [#117](https://github.com/LazyVim/LazyVim/issues/117) ([5aa85e4](https://github.com/LazyVim/LazyVim/commit/5aa85e47e42e86eb854fc42a4f4a46f1de50a56f))

## [1.2.0](https://github.com/LazyVim/LazyVim/compare/v1.1.0...v1.2.0) (2023-01-22)


### Features

* **extras:** added extra for mini.animate. Highly recommended! ([1a55a16](https://github.com/LazyVim/LazyVim/commit/1a55a167a0eb3eb020af8422fa81cd93fb2d444e))

## [1.1.0](https://github.com/LazyVim/LazyVim/compare/v1.0.0...v1.1.0) (2023-01-22)


### Features

* install latest stable release of lazy.nvim and LazyVim ([8bc321b](https://github.com/LazyVim/LazyVim/commit/8bc321bb554e5fac0110b69d5bda4691dc4e9c8c))
* **lsp:** make it easier to customize LSP keymaps. Fixes [#93](https://github.com/LazyVim/LazyVim/issues/93) ([47ba46f](https://github.com/LazyVim/LazyVim/commit/47ba46f184ce34b634d70a2ef8739cccbbc23258))
* **lsp:** setup lsp servers not supported by mason-lspconfig and added mason=false to skip server setup by mason. Fixes [#95](https://github.com/LazyVim/LazyVim/issues/95) ([cc0171e](https://github.com/LazyVim/LazyVim/commit/cc0171e770505c779374bac078d2e6f62a0f16d8))


### Bug Fixes

* **core:** use lazy.nvim version configured by the user ([254d0ca](https://github.com/LazyVim/LazyVim/commit/254d0ca26185b1a46695199a50d4e6290f1f27a1))
* **indent-blankline:** load on BufReadPost to prevent neo-tree errors ([1ea6534](https://github.com/LazyVim/LazyVim/commit/1ea6534ba4224339b5c74c417daf127696ebf031))
* **keymaps:** switch `&lt;leader&gt;gg` and `<leader>gG` to be consistent with the other keymaps ([7be8efa](https://github.com/LazyVim/LazyVim/commit/7be8efaa8435eec460334ecf94ead7fc3eaa6f39))
* **treesitter:** dont add to ensure_installed when "all". Fixes [#98](https://github.com/LazyVim/LazyVim/issues/98) ([280f4cf](https://github.com/LazyVim/LazyVim/commit/280f4cf2998fd26050af5a1e7b0d6acfc5be7e15))

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
