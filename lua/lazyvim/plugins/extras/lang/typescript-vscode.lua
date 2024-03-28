-- https://github.com/neovim/neovim/issues/21749#issuecomment-1378720864
-- Fix loading of json5 for "Joakker/lua-json5"
-- table.insert(vim._so_trails, "/?.dylib")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx", "embedded_template" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.servers, {
        -- ---@type lspconfig.options.vtsls
        vtsls = {
          settings = {
            vtsls = {
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
              -- otherwise it would ask every time if you want to update imports, which is a bit annoying
              updateImportsOnFileMove = {
                enabled = "always",
              },
            },
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = {
                enabled = "always",
              },
              -- cool feature, but increases ram usage a lot
              -- referencesCodeLens = {
              --   enabled = true,
              --   showOnAllFunctions = true,
              -- },
            },
          },
        },
      })
    end,
    dependencies = {
      "yioneko/nvim-vtsls",
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          vim.list_extend(opts.ensure_installed, {
            "vtsls",
            "js-debug-adapter",
            "chrome-debug-adapter",
          })
        end,
      },
    },
    opts = function()
      local languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      local dap = require("dap")

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      -- pwa-chrome isn't working fully.
      -- https://stackoverflow.com/a/73427518/5930949
      dap.adapters["chrome"] = {
        type = "executable",
        command = "chrome-debug-adapter",
        -- host = "localhost",
        -- port = "${port}",
        -- executable = {
        --     command = "chrome-debug-adapter",
        --     -- args = { "${port}" },
        -- },
      }

      require("dap.ext.vscode").load_launchjs(nil, {
        ["pwa-node"] = languages,
        ["node"] = languages,
        ["chrome"] = languages,
        ["pwa-chrome"] = languages,
      })

      for _, language in ipairs(languages) do
        if dap.configurations[language] == nil then
          dap.configurations[language] = {}
        end

        if language:find("javascript") then
          vim.list_extend(dap.configurations[language], {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file (node)",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
          })
        end

        if language:find("typescript") then
          vim.list_extend(dap.configurations[language], {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file (tsx)",
              cwd = "${workspaceFolder}",
              -- NOTE: you would need to have tsx installed globally (`npm i tsx -g`)
              runtimeExecutable = "tsx",
              args = { "${file}" },
              sourceMaps = true,
              protocol = "inspector",
              skipFiles = { "<node_internals>/**", "node_modules/**" },
              resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
              },
            },
          })
        end

        vim.list_extend(dap.configurations[language], {
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        })
      end
    end,
  },
  {
    -- we need workspace/didRename for renaming to work with vtsls
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neo-tree/neo-tree.nvim",
      },
      opts = {},
    },
  },
}
