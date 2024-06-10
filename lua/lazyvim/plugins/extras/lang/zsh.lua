-- a workaround for getting completions in zsh scripts
return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "zsh",
      -- root = { ""},
    })
  end,
  {
    "mason.nvim",
    opts = { ensure_installed = { "beautysh" } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.zsh,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "zsh", "bash" },
        },
      },
    },
  },
}
