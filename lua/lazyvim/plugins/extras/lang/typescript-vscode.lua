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
      -- set default server config to use nvim-vtsls one, which would allow use to use the plugin
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig

      -- ---@type lspconfig.options.vtsls
      opts.servers.vtsls = {
        -- you can view all keys here: https://github.com/yioneko/nvim-vtsls#commands
        -- this keymaps will only appear at the lsp filetype (TypeScript, JavaScript). So they won't interfere with your other keymaps
        keys = {
          {
            "<leader>co",
            function()
              require("vtsls").commands.organize_imports(0)
            end,
            desc = "Organize Imports",
          },
          {
            "<leader>cM",
            function()
              require("vtsls").commands.add_missing_imports(0)
            end,
            desc = "Add missing imports",
          },
          {
            "<leader>cD",
            function()
              require("vtsls").commands.fix_all(0)
            end,
            desc = "Fix all diagnostics",
          },
          {
            "<leader>cLL",
            function()
              require("vtsls").commands.open_tsserver_log()
            end,
            desc = "Open Vtsls Log",
          },
          {
            "<leader>cR",
            function()
              require("vtsls").commands.rename_file(0)
            end,
            desc = "Rename File",
          },
          {
            "<leader>cu",
            function()
              require("vtsls").commands.file_references(0)
            end,
            desc = "Show File Uses(References)",
          },
          {
            "<leader>ctc",
            function()
              require("vtsls").commands.goto_project_config(0)
            end,
            desc = "Open Project Config",
          },
        },
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
            -- enables inline hints
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
            -- otherwise it would ask every time if you want to update imports, which is a bit annoying
            updateImportsOnFileMove = {
              enabled = "always",
            },
            -- cool feature, but increases ram usage
            -- referencesCodeLens = {
            --   enabled = true,
            --   showOnAllFunctions = true,
            -- },
          },
          typescript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
            updateImportsOnFileMove = {
              enabled = "always",
            },
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
            -- enables project wide error reporting similar to vscode
            -- tsserver = {
            --   experimental = {
            --     enableProjectDiagnostics = true,
            --   },
            -- },
          },
        },
      }
    end,
    dependencies = {
      {
        "yioneko/nvim-vtsls",
        handlers = {},
      },
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
