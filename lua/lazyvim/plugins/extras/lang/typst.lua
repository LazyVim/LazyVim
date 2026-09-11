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
          keys = {
            {
              "<leader>cP",
              function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                local file_name = vim.fn.fnamemodify(buf_name, ":t")
                LazyVim.lsp.execute({
                  title = "Pin Main",
                  filter = "tinymist",
                  command = "tinymist.pinMain",
                  arguments = { buf_name },
                })
                LazyVim.info("Tinymist: Pinned " .. file_name)
              end,
              desc = "Pin main file",
            },
          },
          single_file_support = true, -- Fixes LSP attachment in non-Git directories
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
    keys = {
      {
        "<leader>cp",
        ft = "typst",
        "<cmd>TypstPreviewToggle<cr>",
        desc = "Toggle Typst Preview",
      },
    },
    opts = function()
      local is_windows = vim.fn.has("win32") == 1
      local tinymist_bin = "tinymist"
      local tinymist_path = is_windows and (tinymist_bin .. ".cmd") or tinymist_bin

      return {
        dependencies_bin = {
          tinymist = tinymist_path,
        },
      }
    end,
  },

  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        typst = { "// %s", "/* %s */" },
      },
    },
  },
}
