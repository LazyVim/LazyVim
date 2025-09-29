return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "tex", "plaintex", "bib" },
      root = { ".latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
    })
  end,

  -- Add BibTeX/LaTeX to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex" })
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
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

      vim.g.vimtex_mappings_enabled = false

      local augroup = vim.api.nvim_create_augroup("vimtexConfig", {})
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        group = augroup,
        callback = function(event)
          local wk = require("which-key")
          wk.add({
            buffer = event.buf,
            {
              "<localleader>l",
              group = "VimTeX",
              icon = { icon = "", color = "green" },
              mode = "nx",
            },
            {
              mode = "n",
              {
                "<localleader>ll",
                "<plug>(vimtex-compile)",
                desc = "Compile",
                icon = { icon = "", color = "green" },
              },
              {
                "<localleader>lL",
                "<plug>(vimtex-compile-selected)",
                desc = "Compile selected",
                icon = { icon = "", color = "green" },
                mode = "nx",
              },
              {
                "<localleader>li",
                "<plug>(vimtex-info)",
                desc = "Information",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>lI",
                "<plug>(vimtex-info-full)",
                desc = "Full information",
                icon = { icon = "󰙎", color = "purple" },
              },
              {
                "<localleader>lt",
                "<plug>(vimtex-toc-open)",
                desc = "Table of Contents",
                icon = { icon = "󰠶", color = "purple" },
              },
              {
                "<localleader>lT",
                "<plug>(vimtex-toc-toggle)",
                desc = "Toggle table of Contents",
                icon = { icon = "󰠶", color = "purple" },
              },
              {
                "<localleader>lq",
                "<plug>(vimtex-log)",
                desc = "Log",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>lv",
                "<plug>(vimtex-view)",
                desc = "View",
                icon = { icon = "", color = "green" },
              },
              {
                "<localleader>lr",
                "<plug>(vimtex-reverse-search)",
                desc = "Reverse search",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>lk",
                "<plug>(vimtex-stop)",
                desc = "Stop",
                icon = { icon = "", color = "red" },
              },
              {
                "<localleader>lK",
                "<plug>(vimtex-stop-all)",
                desc = "Stop all",
                icon = { icon = "󰓛", color = "red" },
              },
              {
                "<localleader>le",
                "<plug>(vimtex-errors)",
                desc = "Errors",
                icon = { icon = "", color = "red" },
              },
              {
                "<localleader>lo",
                "<plug>(vimtex-compile-output)",
                desc = "Compile output",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>lg",
                "<plug>(vimtex-status)",
                desc = "Status",
                icon = { icon = "󱖫", color = "purple" },
              },
              {
                "<localleader>lG",
                "<plug>(vimtex-status-full)",
                desc = "Full status",
                icon = { icon = "󱖫", color = "purple" },
              },
              {
                "<localleader>lc",
                "<plug>(vimtex-clean)",
                desc = "Clean",
                icon = { icon = "󰃢", color = "orange" },
              },
              {
                "<localleader>lh",
                "<Cmd>VimtexClearCache ALL<cr>",
                desc = "Clear all cache",
                icon = { icon = "󰃢", color = "grey" },
              },
              {
                "<localleader>lC",
                "<plug>(vimtex-clean-full)",
                desc = "Full clean",
                icon = { icon = "󰃢", color = "red" },
              },
              {
                "<localleader>lx",
                "<plug>(vimtex-reload)",
                desc = "Reload",
                icon = { icon = "󰑓", color = "green" },
              },
              {
                "<localleader>lX",
                "<plug>(vimtex-reload-state)",
                desc = "Reload state",
                icon = { icon = "󰑓", color = "cyan" },
              },
              {
                "<localleader>lm",
                "<plug>(vimtex-imaps-list)",
                desc = "Input mappings",
                icon = { icon = "", color = "purple" },
              },
              {
                "<localleader>ls",
                "<plug>(vimtex-toggle-main)",
                desc = "Toggle main",
                icon = { icon = "󱪚", color = "green" },
              },
              {
                "<localleader>la",
                "<plug>(vimtex-context-menu)",
                desc = "Context menu",
                icon = { icon = "󰮫", color = "purple" },
              },
              {
                "ds",
                group = "+surrounding",
                icon = { icon = "󰗅", color = "green" },
              },
              {
                "dse",
                "<plug>(vimtex-env-delete)",
                desc = "environment",
                icon = { icon = "", color = "red" },
              },
              {
                "dsc",
                "<plug>(vimtex-cmd-delete)",
                desc = "command",
                icon = { icon = "", color = "red" },
              },
              {
                "ds$",
                "<plug>(vimtex-env-delete-math)",
                desc = "math",
                icon = { icon = "󰿈", color = "red" },
              },
              {
                "dsd",
                "<plug>(vimtex-delim-delete)",
                desc = "delimiter",
                icon = { icon = "󰅩", color = "red" },
              },
              {
                "cs",
                group = "+surrounding",
                icon = { icon = "󰗅", color = "green" },
              },
              {
                "cse",
                "<plug>(vimtex-env-change)",
                desc = "environment",
                icon = { icon = "", color = "blue" },
              },
              {
                "csc",
                "<plug>(vimtex-cmd-change)",
                desc = "command",
                icon = { icon = "", color = "blue" },
              },
              {
                "cs$",
                "<plug>(vimtex-env-change-math)",
                desc = "math environment",
                icon = { icon = "󰿈", color = "blue" },
              },
              {
                "csd",
                "<plug>(vimtex-delim-change-math)",
                desc = "delimiter",
                icon = { icon = "󰅩", color = "blue" },
              },
              {
                "ts",
                group = "+surrounding",
                icon = { icon = "󰗅", color = "green" },
                mode = "nx",
              },
              {
                "tsf",
                "<plug>(vimtex-cmd-toggle-frac)",
                desc = "fraction",
                icon = { icon = "󱦒", color = "yellow" },
                mode = "nx",
              },
              {
                "tsc",
                "<plug>(vimtex-cmd-toggle-star)",
                desc = "command",
                icon = { icon = "", color = "yellow" },
              },
              {
                "tse",
                "<plug>(vimtex-env-toggle-star)",
                desc = "environment",
                icon = { icon = "", color = "yellow" },
              },
              {
                "ts$",
                "<plug>(vimtex-env-toggle-math)",
                desc = "math environment",
                icon = { icon = "󰿈", color = "yellow" },
              },
              {
                "tsb",
                "<plug>(vimtex-env-toggle-break)",
                desc = "break",
                icon = { icon = "󰿈", color = "yellow" },
              },
              {
                "<F6>",
                "<plug>(vimtex-env-surround-line)",
                desc = "Surround line with environment",
                icon = { icon = "", color = "purple" },
              },
              {
                "<F6>",
                "<plug>(vimtex-env-surround-visual)",
                desc = "Surround selection with environment",
                icon = { icon = "", color = "purple" },
                mode = "x",
              },
              {
                "tsd",
                "<plug>(vimtex-delim-toggle-modifier)",
                desc = "delimiter",
                icon = { icon = "󰅩", color = "yellow" },
                mode = "nx",
              },
              {
                "tsD",
                "<plug>(vimtex-delim-toggle-modifier-reverse)",
                desc = "reverse surrounding delimiter",
                icon = { icon = "󰅩", color = "yellow" },
                mode = "nx",
              },
              {
                "<F7>",
                "<plug>(vimtex-cmd-create)",
                desc = "Create command",
                icon = { icon = "󰅩", color = "green" },
                mode = "nxi",
              },
              {
                "]]",
                "<plug>(vimtex-delim-close)",
                desc = "Close delimiter",
                icon = { icon = "󰅩", color = "green" },
                mode = "i",
              },
              {
                "<F8>",
                "<plug>(vimtex-delim-add-modifiers)",
                desc = "Add \\left and \\right",
                icon = { icon = "󰅩", color = "green" },
                mode = "n",
              },
            },
            {
              mode = "xo",
              {
                "ac",
                "<plug>(vimtex-ac)",
                desc = "command",
                icon = { icon = "", color = "orange" },
              },
              {
                "ic",
                "<plug>(vimtex-ic)",
                desc = "command",
                icon = { icon = "", color = "orange" },
              },
              {
                "ad",
                "<plug>(vimtex-ad)",
                desc = "delimiter",
                icon = { icon = "󰅩", color = "orange" },
              },
              {
                "id",
                "<plug>(vimtex-id)",
                desc = "delimiter",
                icon = { icon = "󰅩", color = "orange" },
              },
              {
                "ae",
                "<plug>(vimtex-ae)",
                desc = "environment",
                icon = { icon = "", color = "orange" },
              },
              {
                "ie",
                "<plug>(vimtex-ie)",
                desc = "environment",
                icon = { icon = "", color = "orange" },
              },
              {
                "a$",
                "<plug>(vimtex-a$)",
                desc = "math",
                icon = { icon = "󰿈", color = "orange" },
              },
              {
                "i$",
                "<plug>(vimtex-i$)",
                desc = "math",
                icon = { icon = "󰿈", color = "orange" },
              },
              {
                "aP",
                "<plug>(vimtex-aP)",
                desc = "section",
                icon = { icon = "󰚟", color = "orange" },
              },
              {
                "iP",
                "<plug>(vimtex-iP)",
                desc = "section",
                icon = { icon = "󰚟", color = "orange" },
              },
              {
                "am",
                "<plug>(vimtex-am)",
                desc = "item",
                icon = { icon = "", color = "orange" },
              },
              {
                "im",
                "<plug>(vimtex-im)",
                desc = "item",
                icon = { icon = "", color = "orange" },
              },
            },
            {
              mode = "nxo",
              {
                "%",
                "<plug>(vimtex-%)",
                desc = "Matching pair",
                icon = { icon = "󰐱", color = "cyan" },
              },
              {
                "]]",
                "<plug>(vimtex-]])",
                desc = "Next end of a section",
                icon = { icon = "󰚟", color = "cyan" },
              },
              {
                "][",
                "<plug>(vimtex-][)",
                desc = "Next beginning of a section",
                icon = { icon = "󰚟", color = "cyan" },
              },
              {
                "[]",
                "<plug>(vimtex-[])",
                desc = "Previous end of a section",
                icon = { icon = "󰚟", color = "cyan" },
              },
              {
                "[[",
                "<plug>(vimtex-[[)",
                desc = "Previous beginning of a section",
                icon = { icon = "󰚟", color = "cyan" },
              },
              {
                "]m",
                "<plug>(vimtex-]m)",
                desc = "Next start of an environment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "]M",
                "<plug>(vimtex-]M)",
                desc = "Next end of an environment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "[m",
                "<plug>(vimtex-[m)",
                desc = "Previous start of an environment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "[M",
                "<plug>(vimtex-[M)",
                desc = "Previous end of an environment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "]n",
                "<plug>(vimtex-]n)",
                desc = "Next start of math",
                icon = { icon = "󰿈", color = "cyan" },
              },
              {
                "]N",
                "<plug>(vimtex-]N)",
                desc = "Next end of math",
                icon = { icon = "󰿈", color = "cyan" },
              },
              {
                "[n",
                "<plug>(vimtex-[n)",
                desc = "Previous start of math",
                icon = { icon = "󰿈", color = "cyan" },
              },
              {
                "[N",
                "<plug>(vimtex-[N)",
                desc = "Previous end of math",
                icon = { icon = "󰿈", color = "cyan" },
              },
              {
                "]r",
                "<plug>(vimtex-]r)",
                desc = "Next start of frame environment",
                icon = { icon = "󰹉", color = "cyan" },
              },
              {
                "]R",
                "<plug>(vimtex-]R)",
                desc = "Next end of frame environment",
                icon = { icon = "󰹉", color = "cyan" },
              },
              {
                "[r",
                "<plug>(vimtex-[r)",
                desc = "Previous start of frame environment",
                icon = { icon = "󰹉", color = "cyan" },
              },
              {
                "[R",
                "<plug>(vimtex-[R)",
                desc = "Previous end of frame environment",
                icon = { icon = "󰹉", color = "cyan" },
              },
              {
                "]/",
                "<plug>(vimtex-]/)",
                desc = "Next start of a comment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "]*",
                "<plug>(vimtex-]star)",
                desc = "Next end of a comment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "[/",
                "<plug>(vimtex-[/)",
                desc = "Previous start of a comment",
                icon = { icon = "", color = "cyan" },
              },
              {
                "[*",
                "<plug>(vimtex-[star)",
                desc = "Previous end of a comment",
                icon = { icon = "", color = "cyan" },
              },
            },
            {
              "K",
              "<plug>(vimtex-doc-package)",
              desc = "See package documentation",
              icon = { icon = "󱔗", color = "azure" },
            },
          })
        end,
      })
    end,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
    },
  },

  -- Correctly setup lspconfig for LaTeX 🚀
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {
          keys = {
            { "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
          },
        },
      },
    },
  },
}
