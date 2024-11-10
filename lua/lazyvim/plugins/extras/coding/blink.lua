return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      -- { "saghen/blink.compat", opts = {} },
    },
    event = "InsertEnter",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
        autocomplete = {
          -- draw = "reversed",
          winblend = vim.o.pumblend,
        },
        documentation = {
          auto_show = true,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },

      -- experimental signature help support
      -- trigger = { signature_help = { enabled = true } }
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        completion = {
          -- remember to enable your providers here
          enabled_providers = { "lsp", "path", "snippets", "buffer" },
        },
      },

      keymap = {
        preset = "enter",
        ["<tab>"] = {
          "snippet_forward",
          function()
            return LazyVim.cmp.ai_accept()
          end,
          "fallback",
        },
      },
    },
    ---@param opts blink.cmp.Config
    config = function(_, opts)
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = opts.sources.providers[source]
          or {
            name = source,
            module = "blink.compat.source",
          }
        if not vim.tbl_contains(opts.sources.completion.enabled_providers, source) then
          table.insert(opts.sources.completion.enabled_providers, source)
        end
      end
      require("blink.cmp").setup(opts)
    end,
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
