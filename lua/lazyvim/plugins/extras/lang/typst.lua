return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "typst" },
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst" },
    },
  },

  -- Wait until this package is available in the mason-registry
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = { "typstyle" },
  --   },
  -- },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typst = { "typstyle" },
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview" },
    build = function()
      require("typst-preview").update()
    end,
    opts = {
      dependencies_bin = {
        ["typst-preview"] = "tinymist",
      },
    },
  },
}
