return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    opts_extend = { "sources.completion.enabled_providers" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      { "saghen/blink.compat", opts = {} },
    },
    event = "InsertEnter",

    -- use a release tag to download pre-built binaries
    version = "*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap. when defining your own, no keybinds will be assigned automatically.
      keymap = "default",

      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
      windows = {
        documentation = {
          auto_show = true,
        },
        ghost_text = {
          enabled = true,
        },
      },

      -- experimental auto-brackets support
      -- accept = { auto_brackets = { enabled = true } }

      -- experimental signature help support
      -- trigger = { signature_help = { enabled = true } }
      sources = {
        completion = {
          -- remember to enable your providers here
          enabled_providers = { "lsp", "path", "snippets", "buffer" },
        },
      },
    },
  },

  -- add icons
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.kind_icons = LazyVim.config.icons.kinds
    end,
  },

  -- lazydev
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        completion = {
          -- add lazydev to your completion providers
          enabled_providers = { "lazydev" },
        },
        providers = {
          lsp = {
            -- dont show LuaLS require statements when lazydev has items
            fallback_for = { "lazydev" },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
          },
        },
      },
    },
  },
}
