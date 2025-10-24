return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "handlebars", "typescript", "javascript", "typescript.glimmer", "javascript.glimmer" },
      root = { "ember-cli-build.js" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "css", "glimmer", "glimmer_javascript", "glimmer_typescript" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ember = {},
      },
    },
  },
  {
    "conform.nvim",
    opts = function(_, opts)
      if LazyVim.has_extra("formatting.prettier") then
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        opts.formatters_by_ft.glimmer = { "prettier" }
      end
    end,
  },
}
