return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "vim" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "vim", "vimdoc" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "vim-language-server" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vimls = {},
      },
    },
  },
}
