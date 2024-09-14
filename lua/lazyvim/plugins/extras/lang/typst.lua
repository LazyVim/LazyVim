return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "typst" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "typst" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typst_lsp = {},
      },
    },
  },
  -- Typst preview
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    build = function()
      require("typst-preview").update()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "typst",
        "<cmd>TypstPreviewToggle<cr>",
        desc = "Typst Preview",
      },
    },
  },
}
