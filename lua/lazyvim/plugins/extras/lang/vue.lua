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
    opts = { ensure_installed = { "vue", "css" } },
  },

  -- Add LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vue_ls = {},
        vtsls = {},
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if not opts.servers.vtsls or opts.servers.vtsls.enabled == false then
        LazyVim.warn({
          "The `lang.vue` extra requires `vtsls` for TypeScript integration.",
          "Enable the `lang.typescript.vtsls` extra, or set `vim.g.lazyvim_ts_lsp = \"vtsls\"`.",
          "If you are using `lang.typescript.tsgo`, disable it so `vtsls` can be used for `lang.vue`.",
        }, {
          title = "LazyVim",
          once = true,
        })
        return
      end

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
