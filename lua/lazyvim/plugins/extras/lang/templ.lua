return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "templ",
    })
  end,
  "joerdav/templ.vim",
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "templ" } },
  },
}
