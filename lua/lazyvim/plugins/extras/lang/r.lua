return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "r",
      root = { "*.R", "*.Rmd", "*qmd" },
    })
  end,
  {
    "R-nvim/R.nvim",
    config = function()
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_args = { "--quiet", "--no-save" },
        hook = {
          on_filetype = function()
            -- This function will be called at the FileType event
            -- of files supported by R.nvim. This is an
            -- opportunity to create mappings local to buffers.
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})

            -- Increase the width of which-key to handle the r-nvim descriptions
            local wk = require("which-key")
            wk.setup({
              layout = {
                width = { min = 20, max = 100 }, -- min and max width of the columns
              },
            })
            -- Workaround from https://github.com/folke/which-key.nvim/issues/514#issuecomment-1987286901
            wk.register({
              ["<localleader>"] = {
                a = { name = "+(a)ll", ["🚫"] = "which_key_ignore" },
                b = { name = "+(b)etween marks", ["🚫"] = "which_key_ignore" },
                c = { name = "+(c)hunks", ["🚫"] = "which_key_ignore" },
                f = { name = "+(f)unctions", ["🚫"] = "which_key_ignore" },
                g = { name = "+(g)oto", ["🚫"] = "which_key_ignore" },
                k = { name = "+(k)nit", ["🚫"] = "which_key_ignore" },
                p = { name = "+(p)aragraph", ["🚫"] = "which_key_ignore" },
                r = { name = "+(r) general", ["🚫"] = "which_key_ignore" },
                s = { name = "+(s)plit or (s)end", ["🚫"] = "which_key_ignore" },
                t = { name = "+(t)erminal", ["🚫"] = "which_key_ignore" },
                v = { name = "+(v)iew", ["🚫"] = "which_key_ignore" },
              },
            })
          end,
        },
        min_editor_width = 72,
        rconsole_width = 78,
        disable_cmds = {
          "RClearConsole",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
        synctex = false,
        pdfviewer = "open",
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = "on startup"
        opts.objbr_auto_start = true
      end
      require("r").setup(opts)
    end,
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "R-nvim/cmp-r" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "cmp_r" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline", "r", "rnoweb" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        r_language_server = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("DESCRIPTION", "NAMESPACE", ".Rbuildignore")(fname)
              or require("lspconfig.util").find_git_ancestor(fname)
              or vim.loop.os_homedir()
          end,
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "shunsambongi/neotest-testthat",
    },
    opts = {
      adapters = {
        ["neotest-testthat"] = {},
      },
    },
  },
}
