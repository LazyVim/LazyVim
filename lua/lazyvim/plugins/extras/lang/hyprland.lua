local hyprland_roots = { "hyprland.conf", ".hyprlsignore" }

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "hyprlang",
      root = hyprland_roots,
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        extension = { hl = "hyprlang" },
        filename = { ["hyprland.conf"] = "hyprlang" },
        pattern = {
          [".+%.conf"] = function(path)
            return vim.fs.root(path, hyprland_roots) and "hyprlang" or nil
          end,
        },
      })
    end,
    opts = { ensure_installed = { "hyprlang" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hyprls = {
          root_markers = { "hyprland.conf", ".hyprlsignore", ".git" },
        },
      },
    },
  },
}
