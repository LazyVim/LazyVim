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

  -- depends on the typescript extra
  { import = "lazyvim.plugins.extras.lang.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "astro" })
      end
    end,
  },

  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@astrojs/ts-plugin",
          location = LazyVim.get_pkg_path(
            "astro-language-server",
            "/node_modules/@astrojs/ts-plugin",
            { warn = false }
          ),
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },
}
