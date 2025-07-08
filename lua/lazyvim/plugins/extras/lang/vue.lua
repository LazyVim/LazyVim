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

  -- Configure vtsls (the TypeScript plugin host) with @vue/typescript-plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.vtsls = opts.servers.vtsls or {}
      opts.servers.vtsls.filetypes = opts.servers.vtsls.filetypes or {}
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

  -- Hook vue_ls to forward requests to vtsls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = { -- when LazyVim switches to nvim-lspconfig ≥ v2.2.0 rename this to `vue_ls`
          on_init = function(client)
            client.handlers["tsserver/request"] = function(_, result, context)
              -- find the vtsls client
              local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
              if #clients == 0 then
                vim.notify("Could not find `vtsls` client, Vue LSP features will be disabled", vim.log.levels.ERROR)
                return
              end
              local ts_client = clients[1]
              -- unpack the forwarded request
              local params = unpack(result)
              local id, command, payload = unpack(params)
              -- forward it
              ts_client:exec_cmd({
                title = "vue_request_forward",
                command = "typescript.tsserverRequest",
                arguments = { command, payload },
              }, { bufnr = context.bufnr }, function(_, resp)
                -- send the tsserver/response back to Vue LSP
                client.notify("tsserver/response", { { id, resp.body } })
              end)
            end
          end,
        },
      },
    },
  },
}
