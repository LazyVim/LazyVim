local map = LazyVim.keymap_set
local k = require("lazyvim.keymaps").get_keymaps()

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
          map("n", k.r_send, "<Plug>RDSendLine", { buffer = true })
          map("v", k.r_send, "<Plug>RSendSelection", { buffer = true })

          local wk = require("which-key")
          wk.add({
            buffer = true,
            { k.r_send_all, group = "all" },
            { k.r_send_between_marks, group = "between marks" },
            { k.r_send_chunks, group = "chunks" },
            { k.r_send_functions, group = "functions" },
            { k.r_send_goto, group = "goto" },
            { k.r_send_install, group = "install" },
            { k.r_send_knit, group = "knit" },
            { k.r_send_paragraph, group = "paragraph" },
            { k.r_send_quarto, group = "quarto" },
            { k.r_send_general, group = "r general" },
            { k.r_send_split_or_send, group = "split or send" },
            { k.r_send_terminal, group = "terminal" },
            { k.r_send_view, group = "view" },
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
