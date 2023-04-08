return {

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        dashboard = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
      custom_highlights = function(c)
        return {
          -- Use tokyonight style leap highlights.
          LeapMatch = { fg = c.pink, bold = true },
          LeapLabelPrimary = { fg = c.green, bold = true },
          LeapLabelSecondary = { fg = c.blue, bold = true },
          LeapBackdrop = { fg = c.overlay0 },
          NavicText = { fg = c.text, bg = c.none },
        }
      end,
    },
  },
}
