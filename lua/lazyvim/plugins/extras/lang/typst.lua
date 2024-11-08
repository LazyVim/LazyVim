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

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          single_file_support = true,
          root_dir = function()
            LazyVim.root.get()
          end,
          settings = {
            formatterMode = "typstyle",
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        typst = { "typstyle", lsp_format = "prefer" },
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
    build = function(plugin)
      local typst_preview = require("typst-preview")
      typst_preview.setup(plugin.opts)
      typst_preview.update()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "typst",
        "<cmd>TypstPreviewToggle<cr>",
        desc = "Typst Preview",
      },
    },
    opts = {
      dependencies_bin = {
        tinymist = "tinymist",
      },
    },
  },
}
