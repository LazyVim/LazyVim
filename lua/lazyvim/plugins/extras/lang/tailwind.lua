return {
  recommended = function()
    return LazyVim.extras.wants({
      root = {
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.cjs",
        "postcss.config.mjs",
        "postcss.config.ts",
      },
    })
  end,
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          local tw = LazyVim.lsp.get_raw_config("tailwindcss")
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Additional settings for Phoenix projects
          opts.settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          }

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
    },
    opts = function(_, opts)
      -- original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      windows = {
        autocomplete = {
          draw = function(ctx)
            _G.blink_color_cache = _G.blink_color_cache or {} ---@type table<string, boolean>
            vim.api.nvim_create_autocmd("ColorScheme", {
              callback = function()
                _G.blink_color_cache = {}
              end,
            })
            local A = require("blink.cmp.windows.autocomplete")
            --- @type blink.cmp.Component[]
            local ret = A.render_item_reversed(ctx)
            if
              ctx.item.kind == vim.lsp.protocol.CompletionItemKind.Color
              and type(ctx.item.documentation) == "string"
              and ctx.item.documentation:match("^#[a-zA-Z0-9]+$")
            then
              local color = ctx.item.documentation
              local group = "BlinkColor" .. color:sub(2)
              if not _G.blink_color_cache[group] then
                vim.api.nvim_set_hl(0, group, { fg = color })
                vim.api.nvim_set_hl(0, group .. "Full", { fg = color, bg = color })
                _G.blink_color_cache[group] = true
              end
              for c, comp in ipairs(ret) do
                if type(comp) == "table" and comp.hl_group == "BlinkCmpKindColor" then
                  comp.hl_group = group
                  table.insert(ret, c, { "   ", hl_group = group .. "Full" })
                  table.insert(ret, c + 1, " ")
                  break
                end
              end
            end
            return ret
          end,
        },
      },
    },
  },
}
