return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "astro",
      root = {
        "astro.config.js",
        "astro.config.mjs",
        "astro.config.cjs",
      },
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "astro" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
      },
    },
  },
}
