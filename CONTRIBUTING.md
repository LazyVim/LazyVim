# Contributing to LazyVim

## General Guidelines

- Avoid using Vim plugins whenever possible.
- If an extra requires a Vim plugin, explain why in the PR description.
- Ensure all configurations are overridable by the user, using Lazy's specs.
- Tag specs as `optional` if they should only be enabled when the user has them installed.
- Implement proper lazy-loading for every plugin added in an extra.
- Understand how Lazy's dependencies work. For Lua dependencies, do not specify
  them in the `dependencies` field. Instead, add them as a separate spec with `lazy=true`.

## Contributing an Extra Plugin

- The plugin should be well-known and require significant configuration.
- Simple specs containing just the plugin with some options will not be accepted.

## Contributing an Extra Language

- You should be familiar with the language you are adding.
- You should have experience with the language's ecosystem, including formatters,
  linters, and LSP servers.
- The extra should include the setup most widely used by the community.
- Include Tree-sitter parsers that are not yet the default.
- Include the most widely used LSP server setup.
- Avoid the need for LSP wrapper packages whenever possible.
- Only add a formatter if it is typically used by the community instead of the LSP formatter.
- Only add extra linters if the community typically uses them instead of just the LSP linters.
- Every language extra requires a `recommended` section as part of the extra.
  Check lspconfig server configurations for the proper filetypes and root directories.
  Refer to other extras for creating the `recommended` section.

### Language-Specific Keymaps

- Use `<localleader>` for language-specific keymaps (follows Vim/Neovim convention for filetype-specific mappings).
- For LSP servers, define keymaps in the server's `keys` field, not in `on_attach`:
  ```lua
  servers = {
    rust_analyzer = {
      keys = {
        { "<localleader>e", function() vim.cmd.RustLsp("expandMacro") end, desc = "Expand Macro" },
      }
    }
  }
  ```
- LazyVim's LSP system will automatically resolve and apply these keymaps (see `lua/lazyvim/plugins/lsp/keymaps.lua`).
- Don't override standard LSP keymaps (like `K` for hover, `gd` for definition) unless absolutely necessary.
- Use standard `<leader>c*` keymaps where they make sense (e.g., `<leader>co` for organize imports).
- Refer to the R and Haskell extras for examples of proper `<localleader>` usage.
