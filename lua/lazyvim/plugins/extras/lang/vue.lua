return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "vue",
      root = { "vue.config.js" },
    })
  end,

  -- depends on the typescript extra
  { import = "lazyvim.plugins.extras.lang.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vue" } },
  },

  -- Add LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {},
        vtsls = {},
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      table.insert(opts.servers.vtsls.filetypes, "vue")
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@vue/typescript-plugin",
          location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },
}
