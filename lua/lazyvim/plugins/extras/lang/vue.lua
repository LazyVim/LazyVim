return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "vue",
      root = { "vue.config.js" },
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "vue" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"
        .. "/node_modules/@vue/typescript-plugin"

      opts.servers = vim.tbl_deep_extend("force", opts.servers, {
        volar = {},
        -- Volar 2.0 has discontinued their "take over mode" which in previous version provided support for typescript in vue files.
        -- The new approach to get typescript support involves using the typescript language server along side volar.
        vtsls = {
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  -- Use typescript language server along with vue typescript plugin
                  vue = {
                    name = "@vue/typescript-plugin",
                    location = vue_typescript_plugin,
                    languages = { "vue" },
                  },
                },
              },
            },
          },
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
          },
        },
      })
    end,
  },
}
