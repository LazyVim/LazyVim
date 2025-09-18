# LazyVim Development Instructions

LazyVim is a Neovim configuration framework powered by lazy.nvim that provides a solid foundation for building customized Neovim setups. Users don't use this repository directly - instead, they import LazyVim as a dependency in their own configuration using the [LazyVim starter template](https://github.com/LazyVim/starter).

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Required Dependencies
- Neovim >= 0.11.2 (needs to be built with LuaJIT) - **CRITICAL**: Use exactly this version or newer
- Git >= 2.19.0 (for partial clones support) 
- Rust/Cargo (for stylua linting)
- **NEVER CANCEL ANY BUILD OR TEST COMMAND** - All operations complete quickly but set appropriate timeouts

### Bootstrap Development Environment
Install the following dependencies in order:
```bash
# Install Neovim (Ubuntu/Debian)
sudo apt update
sudo apt install -y neovim

# Verify version requirements
nvim --version  # Should show v0.9.5 or higher

# Install stylua linter for Lua formatting
cargo install stylua

# Verify stylua installation  
~/.cargo/bin/stylua --version
```

### Repository Structure and Navigation
The LazyVim repository is organized as follows:
- `lua/lazyvim/` - Core LazyVim framework code
  - `config/` - Default configuration (autocmds, keymaps, options)
  - `plugins/` - Core plugin configurations and extras
  - `plugins/extras/` - Optional plugin configurations by category (ai, coding, dap, editor, etc.)
  - `util/` - Utility functions and helpers
- `tests/` - Test suites (requires compatible Neovim version)
- `doc/` - Documentation files
- Root config files: `stylua.toml`, `selene.toml`, `.neoconf.json`

### Development Workflow

#### Linting and Code Style
- **Always run formatting before committing**: `~/.cargo/bin/stylua --check lua/`
- **Timing**: Stylua linting completes in ~0.2 seconds - NEVER CANCEL
- **CI will fail if code is not properly formatted**
- Use existing stylua.toml configuration - do not modify formatting rules

#### Testing LazyVim Changes
**IMPORTANT**: LazyVim cannot be tested directly from this repository because it's designed as a framework. Use these approaches:

1. **For Core Framework Testing**:
```bash
# Create a test environment using LazyVim starter
cd /tmp
git clone https://github.com/LazyVim/starter.git lazyvim-test
cd lazyvim-test

# Test basic LazyVim loading (completes in ~1 second)
NVIM_APPNAME=nvim-test nvim --headless +'lua print("LazyVim test")' +'qa!'
```

2. **For Plugin Development**: 
- Test extras plugins in `lua/lazyvim/plugins/extras/` by creating a starter config that imports the specific extra
- Example: `{ import = "lazyvim.plugins.extras.lang.python" }`

3. **Testing Framework Integrity**:
```bash
# Run the basic repository tests (when using compatible Neovim)
# Note: Current tests require vim.uv which needs Neovim >= 0.10
# For older versions, tests may fail due to compatibility issues
nvim --headless -l tests/minit.lua --minitest
```

#### Build and CI Validation
- **There is no traditional "build" process** - LazyVim is a Lua-based configuration framework
- **Pre-commit validation**: Always run `~/.cargo/bin/stylua --check lua/` before committing
- **CI runs stylua formatting checks** - PRs will fail if formatting is incorrect
- **Timing**: All validation steps complete in under 1 second - NEVER CANCEL

### Validation Scenarios
After making changes to LazyVim:

1. **Always test with LazyVim starter template**:
```bash
cd /tmp && rm -rf lazyvim-validation
git clone https://github.com/LazyVim/starter.git lazyvim-validation
cd lazyvim-validation

# Test basic initialization
NVIM_APPNAME=nvim-validation timeout 60 nvim --headless +'qa!'
```

2. **For extras plugin changes**: Create a minimal test config that imports your changed extra and verify it loads without errors

3. **For core changes**: Test that fundamental LazyVim functionality (keymaps, autocmds, plugin loading) works correctly

### Common Tasks and File Locations

#### Adding New Extras
- Location: `lua/lazyvim/plugins/extras/[category]/[name].lua`
- Follow existing patterns in extras directory
- Always include proper lazy-loading configuration
- Reference: Review `lua/lazyvim/plugins/extras/lang/` for language extras examples

#### Modifying Core Plugins
- Core plugins: `lua/lazyvim/plugins/[plugin-name].lua`
- Ensure all configurations remain overridable by users
- Test with starter template to verify user customization capabilities

#### Documentation Updates
- Main docs: `README.md` and language-specific README files (`README-CN.md`, etc.)
- Keep all README versions synchronized for major changes
- Contribution guidelines: `CONTRIBUTING.md`

### Important Repository Details

#### Version and Release Management
- Version defined in: `lua/lazyvim/config/init.lua` (M.version field)
- Releases managed via release-please: `.github/release-please-config.json`
- Changelog: `CHANGELOG.md` (auto-generated)

#### CI/CD Configuration
- Main CI: `.github/workflows/ci.yml` (delegates to folke/github shared workflow)
- Stylua formatting enforced in CI
- Auto-labeling: `.github/workflows/labeler.yml`
- Stale issue management: `.github/workflows/stale.yml`

#### Git Workflow
- Always create feature branches for changes
- PR template guides contribution format: `.github/PULL_REQUEST_TEMPLATE.md`
- Issues use structured templates: `.github/ISSUE_TEMPLATE/`

### Performance and Timing Expectations

All LazyVim development operations are fast:
- Stylua linting: ~0.2 seconds - NEVER CANCEL
- Basic Neovim LazyVim startup test: ~1 second - NEVER CANCEL  
- Repository operations (git, file editing): instantaneous
- **No long-running builds or complex compilation steps**

### Critical Notes for Development

1. **LazyVim is a framework, not an end-user application** - always test changes using the starter template
2. **Maintain user customization capabilities** - all plugin configurations must be overridable
3. **Follow lazy-loading patterns** - every plugin should load only when needed
4. **Preserve backwards compatibility** - changes should not break existing user configurations
5. **Document breaking changes** - any API changes need clear migration paths

### Error Troubleshooting

Common issues and solutions:
- **"module 'lazyvim.util' not found"**: LazyVim modules only available after proper initialization via starter template
- **Test failures with vim.uv**: Use Neovim >= 0.10 or modify tests to use vim.loop for older versions  
- **Stylua failures**: Run `~/.cargo/bin/stylua lua/` to auto-format code before committing
- **Plugin loading issues**: Verify lazy-loading configuration and dependencies are properly specified

Always validate changes thoroughly using the starter template approach before submitting PRs.