return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "julia" },
      root = { "Project.toml" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "julia" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        julials = {
          settings = {
            -- use the same default settings as the Julia VS Code extension
            julia = {
              completionmode = "qualify",
              lint = { missingrefs = "none" },
              inlayHints = {
                static = {
                  enabled = false,
                  variableTypes = { enabled = true },
                },
              },
            },
          },
        },
      },
    },
  },
}
