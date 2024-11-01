local k = require("lazyvim.keymaps").get_keymaps()

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
      { k.dap_prefix, "", desc = "+debug", mode = {"n", "v"} },
      { k.dap_breakpoint_condition, function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { k.dap_toggle_breakpoint, function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { k.dap_continue, function() require("dap").continue() end, desc = "Continue" },
      { k.dap_run_with_args, function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { k.dap_run_to_cursor, function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { k.dap_go_to_line_no_execute, function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { k.dap_step_into, function() require("dap").step_into() end, desc = "Step Into" },
      { k.dap_down, function() require("dap").down() end, desc = "Down" },
      { k.dap_up, function() require("dap").up() end, desc = "Up" },
      { k.dap_run_last, function() require("dap").run_last() end, desc = "Run Last" },
      { k.dap_step_out, function() require("dap").step_out() end, desc = "Step Out" },
      { k.dap_step_over, function() require("dap").step_over() end, desc = "Step Over" },
      { k.dap_pause, function() require("dap").pause() end, desc = "Pause" },
      { k.dap_toggle_repl, function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { k.dap_session, function() require("dap").session() end, desc = "Session" },
      { k.dap_terminate, function() require("dap").terminate() end, desc = "Terminate" },
      { k.dap_widgets, function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
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
      { k.toggle_dap_ui, function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { k.dap_eval_dap_ui, function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
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
