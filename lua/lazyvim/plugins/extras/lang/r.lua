local map = LazyVim.keymap_set
local k = require("lazyvim.keymaps").get_keymaps().extras.lang.r

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "r",
      root = { "*.R", "*.Rmd", "*qmd" },
    })
  end,
  {
    "R-nvim/R.nvim",
    lazy = false,
    opts = {
      -- Create a table with the options to be passed to setup()
      R_args = { "--quiet", "--no-save" },
      hook = {
        on_filetype = function()
          -- This function will be called at the FileType event
          -- of files supported by R.nvim. This is an
          -- opportunity to create mappings local to buffers.
          map("n", k.send, "<Plug>RDSendLine", { buffer = true })
          map("v", k.send, "<Plug>RSendSelection", { buffer = true })

          local wk = require("which-key")
          wk.add({
            buffer = true,
            { k.send_all, group = "all" },
            { k.send_between_marks, group = "between marks" },
            { k.send_chunks, group = "chunks" },
            { k.send_functions, group = "functions" },
            { k.send_goto, group = "goto" },
            { k.send_install, group = "install" },
            { k.send_knit, group = "knit" },
            { k.send_paragraph, group = "paragraph" },
            { k.send_quarto, group = "quarto" },
            { k.send_general, group = "r general" },
            { k.send_split_or_send, group = "split or send" },
            { k.send_terminal, group = "terminal" },
            { k.send_view, group = "view" },
          })
        end,
      },
      pdfviewer = "",
    },
    config = function(_, opts)
      vim.g.rout_follow_colorscheme = true
      require("r").setup(opts)
      require("r.pdf.generic").open = vim.ui.open
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "R-nvim/cmp-r" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "cmp_r" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "r", "rnoweb" } },
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
