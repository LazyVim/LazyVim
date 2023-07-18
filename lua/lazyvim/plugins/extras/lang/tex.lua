return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<LocalLeader>l"] = { name = "+vimtex" },
      },
    },
  },

  -- Add BibTeX/LaTeX to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
      end
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },

  {
    "lervag/vimtex",
    version = "*",
    ft = { "bib", "tex" },
    keys = {
      { "<LocalLeader>ld", "<Cmd>VimtexDocPackage<CR>", desc = "Open Documentation" },
    },
    config = function()
      vim.opt.conceallevel = 2
      vim.g.vimtex_complete_enabled = 0 -- use texlab for completion
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

      vim.g.vimtex_view_method = vim.fn.has("mac") == 1 and "skim" or "zathura"
    end,
  },

  -- Correctly setup lspconfig for LaTeX 🚀
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              chktex = {
                onOpenAndSave = true,
              },
            },
          },
        },
      },
    },
  },
}
