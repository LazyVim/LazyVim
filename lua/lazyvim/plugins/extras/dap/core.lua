local k = require("lazyvim.keymaps").get_keymaps().extras.dap.core

---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

    -- stylua: ignore
    keys = {
      { k.nvim_dap.prefix, "", desc = "+debug", mode = {"n", "v"} },
      { k.nvim_dap.breakpoint_condition, function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { k.nvim_dap.toggle_breakpoint, function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { k.nvim_dap.continue, function() require("dap").continue() end, desc = "Continue" },
      { k.nvim_dap.run_with_args, function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { k.nvim_dap.run_to_cursor, function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { k.nvim_dap.go_to_line_no_execute, function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { k.nvim_dap.step_into, function() require("dap").step_into() end, desc = "Step Into" },
      { k.nvim_dap.down, function() require("dap").down() end, desc = "Down" },
      { k.nvim_dap.up, function() require("dap").up() end, desc = "Up" },
      { k.nvim_dap.run_last, function() require("dap").run_last() end, desc = "Run Last" },
      { k.nvim_dap.step_out, function() require("dap").step_out() end, desc = "Step Out" },
      { k.nvim_dap.step_over, function() require("dap").step_over() end, desc = "Step Over" },
      { k.nvim_dap.pause, function() require("dap").pause() end, desc = "Pause" },
      { k.nvim_dap.toggle_repl, function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { k.nvim_dap.session, function() require("dap").session() end, desc = "Session" },
      { k.nvim_dap.terminate, function() require("dap").terminate() end, desc = "Terminate" },
      { k.nvim_dap.widgets, function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },

    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },

  -- fancy UI for the debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { k.nvim_dap_ui.toggle_dap_ui, function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { k.nvim_dap_ui.eval_dap_ui, function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },

  -- mason.nvim integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
}
