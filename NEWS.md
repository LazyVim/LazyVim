# What's new?

## 13.x

- **LazyVim** now uses `Snacks.dashboard` as the default dashboard.
  Check the [docs](https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md),
  for more information and examples.

- A new [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) extra
  is available for those who prefer the old dashboard.

- Big new release with a lot of changes and improvements!

- The biggest change is the move of a bunch of core features to
  [snacks.nvim](https://github.com/folke/snacks.nvim) and fully
  integrating it into **LazyVim**.

- I highly suggest having a look at the **snacks.nvim** documentation
  to see all the new features and improvements. Most important changes:
  - `Snacks.notifier` for notifications instead of `nvim-notify`
  - `Snacks.terminal` is similar to `lazyterm`, but has more features
    and creates bottom splits by default (similar to the `edgy` integrating)

## 12.x

- **Markdown Extra**: [headlines.nvim](https://github.com/lukas-reineke/headlines.nvim) has been removed in favor of [markdown.nvim](https://github.com/MeanderingProgrammer/markdown.nvim)
  to spice up your markdown files.

- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) has been removed in favor of [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim).
  **grug-far.nvim** has a great UI and feels more intuitive to use.

- This **news** is now also available on the website at [https://www.lazyvim.org/news](https://www.lazyvim.org/news)

- **prettier** extra now works for all prettier supported filetypes
  and will be enabled for astro/svelte extra if you have a proper
  config file with the correct prettier plugin

- **New Language Support:** SQL, Clojure, Thrift, Elm, Gleam, Angular,
  NuShell, Svelte, Kotlin, Astro, Toml and PHP

- **New Extras:** `copilot-chat`, `git`, `octo`, `inc-rename` and `neogen`

- The **typescript** extra now uses `vtsls` instead of `tsserver`

- **Neovim >= 0.10** now uses the much faster [lazydev.nvim](https://github.com/folke/lazydev.nvim)
  instead of `neodev.nvim`

- moved `neoconf.nvim` to extras. Project specific LSP settings
  can be done with a `.lazy.lua` file instead.

## 11.x

- **Keymaps:**

  - `<leader>gB` to open the current repo in the browser
  - `gco` and `gcO` to add a comment below or above the current line
  - `<leader>wm` to toggle window maximize

- **lazydev.nvim:** faster alternative to `neodev.nvim`

- **Options:** Added `linebreak=true` to default options.

- `mini.ai` is back as a default plugin! Removing it was a mistake.
  It's a great plugin that enhances the native text objects.

- `:LazyExtras` now has multiple new sections:

  - **Enabled**: extras that are currently enabled
  - **Recommended Languages**: language extras recommended for the current buffer / directory
  - **Recommended Plugins**: extras that are recommended for most users
  - **Plugins**: other plugin extras
  - **Languages**: other language extras

- new option `vim.g.deprecation_warnings` to disable deprecation warnings
  Defaults to `false`. To enable deprecation warnings, set it to `true` in your `options.lua`

- `vim-illuminate` move to extras
  Document highlights now use native lsp functionality by default

Since Neovim 0.10 has been released, I've been working on a new version of **LazyVim**
that is fully compatible with all the latest Neovim features.

Additionally, some core plugins have been moved to extras.

- `native snippets` are now the default on Neovim 0.10
  Older versions of Neovim will use the new `luasnip` extra.

- `native comments` are now the default on Neovim 0.10
  Older versions of Neovim will use the new `mini-comment` extra.
  `nvim-ts-context-commentstring` has been integrated in the native comments.

- `inlay hints` have been in **LazyVim** for a while, but are now
  enabled by default. To disable them:

  ```lua
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    }
  }
  ```

- plugins moved to extras:

  - `mini.surround`
  - `mini.indentscope` scopes are now also highlighted with `indent-blankline`
  - `nvim-treesitter-context`

## 10.x

- added new extra for [mini.diff](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-diff.md)
  This is a plugin similar to gitsigns but with a neat diff overlay
  that can be toggled with `<leader>go`.

- **trouble.nvim** has been rewritten from scratch and is now in beta.
  I've added a new extra for it (`trouble-v3`) for those of you who want to try it out.
  You can find the updated docs [here](https://github.com/folke/trouble.nvim/tree/dev)

- The **lazygit** integration now configures:

  - the theme based on the colorscheme
  - nerd font icons (v3)
  - editor preset is set to `nvim-remote` for better interop with Neovim

- The option `vim.g.lazygit_theme` was renamed to `vim.g.lazygit_config`

- **lazygit** now automatically uses the colors of your current colorscheme.
  This is enabled by default. To disable, add the below to your `options.lua`:

  ```lua
  vim.g.lazygit_config = false
  ```

- Added support for `basedpyright` to the **python** extra.
  Enable in your `options.lua` with:

  ```lua
  vim.g.lazyvim_python_lsp = "basedpyright"
  ```

  Be aware that `basedpyright` is still in development and
  may not work exactly the same as `pyright`.

- User extras under `lua/plugins/extras` can now also be managed
  with **LazyExtras**

- `nvim-ts-autotag` is now included by default

- `nvim-treesitter-context` is now included by default

- Added extra for `symbols-outline.nvim`

- Added extra for `aerial.nvim`

- `nvim-navic` has been removed. If you want to keep using `nvim-navic`,
  you can enable the **editor.navic** extra

- New `:LazyExtras` command for managing **LazyVim** extras

- Improved **formatting**:

  - **LazyVim** can now work with multiple formatters. Types:

    - **primary**: only one primary formatter can be active at a time.
      _(conform, none-ls, LSP)_
    - **secondary**: multiple secondary formatters can be active _(eslint, ...)_

  - **LazyVim** automatically selects the primary formatter based on the
    current available sources and priorities.

  - New `:LazyFormat` command for formatting the current selection or buffer
  - New `:LazyFormatInfo` command for displaying the active formatters
    for the current buffer
  - Auto-formatting can be disabled with:

    ```lua
    vim.g.autoformat = false -- globally
    vim.b.autoformat = false -- buffer-local
    ```

- `none-ls.nvim` is no longer installed by default

  - `conform.nvim` is now the default formatter
  - `nvim-lint` is now the default linter
  - If you want to keep using `none-ls.nvim`,
    you can enable the **lsp.none-ls** extra

- `dashboard.nvim` is the new default dashboard plugin

  - If you want to keep using `alpha.nvim`, you can enable the **ui.alpha** extra

- Improved **root detection**:

  - New `:LazyRoot` command that shows info about the root dir detection
  - Configurable with `vim.g.root_spec`

    ```lua
    -- LazyVim root dir detection
    -- Each entry can be:
    -- * the name of a detector function like `lsp` or `cwd`
    -- * a pattern or array of patterns like `.git` or `lua`.
    -- * a function with signature `function(buf) -> string|string[]`
    vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

    -- To disable root detection set to just "cwd"
    vim.g.root_spec = { "cwd" }
    ```
