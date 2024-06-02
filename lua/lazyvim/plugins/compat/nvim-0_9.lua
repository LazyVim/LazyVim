-- Compatibility with Neovim 0.9
return {
  -- Use LuaSnip instead of native snippets
  { "garymjr/nvim-snippets", enabled = false },
  { import = "lazyvim.plugins.extras.coding.luasnip" },

  -- Use mini.comment instead of ts-comments
  { "folke/ts-comments.nvim", enabled = false },
  { import = "lazyvim.plugins.extras.coding.mini-comment" },

  -- Use neodev instead of lazydev
  { "folke/lazydev.nvim", enabled = false },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
    },
  },
}
