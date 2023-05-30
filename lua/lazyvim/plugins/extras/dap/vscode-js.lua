return {
  "mfussenegger/nvim-dap",

  dependencies = {
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      tag = "v1.*",
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      config = function()
        local vscodeJsDebugPath = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"

        require("dap-vscode-js").setup({
          adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
          debugger_path = vscodeJsDebugPath,
        })
        for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
          require("dap").configurations[language] = {
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach Program (pwa-node, select pid)",
              cwd = "${workspaceFolder}",
              processId = require("dap.utils").pick_process,
              skipFiles = { "<node_internals>/**" },
            },
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch Current File (pwa-node)",
              cwd = vim.fn.getcwd(),
              args = { "${file}" },
              sourceMaps = true,
              protocol = "inspector",
            },
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch Current File (pwa-node with deno)",
              cwd = vim.fn.getcwd(),
              runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
              runtimeExecutable = "deno",
              attachSimplePort = 9229,
            },
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch Test Current File (pwa-node with jest)",
              cwd = vim.fn.getcwd(),
              runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
              runtimeExecutable = "node",
              args = { "${file}", "--coverage", "false" },
              rootPath = "${workspaceFolder}",
              sourceMaps = true,
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
              skipFiles = { "<node_internals>/**", "node_modules/**" },
            },
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch Test Current File (pwa-node with vitest)",
              cwd = vim.fn.getcwd(),
              program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
              args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
              autoAttachChildProcesses = true,
              smartStep = true,
              console = "integratedTerminal",
              skipFiles = { "<node_internals>/**", "node_modules/**" },
            },
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch Test Current File (pwa-node with deno)",
              cwd = vim.fn.getcwd(),
              runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
              runtimeExecutable = "deno",
              attachSimplePort = 9229,
            },
          }
        end
        require("dap.ext.vscode").load_launchjs(nil, {
          ["pwa-chrome"] = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        })
      end,
    },
  },
}
