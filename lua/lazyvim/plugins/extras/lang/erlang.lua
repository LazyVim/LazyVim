return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "erlang" },
      root = { "rebar.config", "erlang.mk" },
    })
  end,
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- erlangls was dropped by nvim-lspconfig (unmaintained upstream);
        -- elp (Erlang Language Platform) is its replacement.
        elp = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "erlang" } },
  },
}
