# What's new?

## 10.x

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
