local filetypes = {
  "css",
  "eruby",
  "html",
  "htmldjango",
  "javascriptreact",
  "less",
  "pug",
  "sass",
  "scss",
  "typescriptreact",
  "vue",
}

vim.filetype.add({
  pcss = "postcss",
  postcss = "postcss",
})

local function list_insert_unique(list, items)
  local set = {}
  for _, item in ipairs(list) do
    set[item] = true
  end
  for _, item in ipairs(items) do
    if not set[item] then
      table.insert(list, item)
      set[item] = true
    end
  end
  return list
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = list_insert_unique(opts.ensure_installed, { "html", "css", "scss", "styled" })
      end
      vim.treesitter.language.register("scss", "less")
      vim.treesitter.language.register("scss", "postcss")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = { init_options = { provideFormatter = false } },
        cssls = { init_options = { provideFormatter = false } },
        emmet_language_server = {
          init_options = {
            --- @type boolean Defaults to `true`
            showAbbreviationSuggestions = false,
            --- @type "always" | "never" Defaults to `"always"`
            showExpandedAbbreviation = "always",
            --- @type boolean Defaults to `false`
            showSuggestionsAsSnippets = true,
          },
          filetypes,
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      list_insert_unique(opts.ensure_installed, {
        "html-lsp",
        "css-lsp",
        "emmet-language-server",
      })
    end,
  },
  {
    "nvim-mini/mini.icons",
    optional = true,
    opts = {
      filetype = {
        postcss = { glyph = "󰌜", hl = "MiniIconsOrange" },
      },
    },
  },
}
