---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    if config.type and config.type == "java" then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
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

    keys = function(_, keys)
      local dap = require("dap")

      local function edit_breakpoint()
        -- Search for an existing breakpoint on this line in this buffer
        ---@return dap.SourceBreakpoint bp that was either found, or an empty placeholder
        local function find_bp()
          local buf_bps = require("dap.breakpoints").get(vim.fn.bufnr())[vim.fn.bufnr()]
          ---@type dap.SourceBreakpoint
          local bp = { condition = "", logMessage = "", hitCondition = "", line = vim.fn.line(".") }
          for _, candidate in ipairs(buf_bps) do
            if candidate.line and candidate.line == vim.fn.line(".") then
              bp = candidate
              break
            end
          end
          return bp
        end

        -- Elicit customization via a UI prompt
        ---@param bp dap.SourceBreakpoint a breakpoint
        local function customize_bp(bp)
          local props = {
            ["Condition"] = {
              value = bp.condition,
              setter = function(v)
                bp.condition = v
              end,
            },
            ["Hit Condition"] = {
              value = bp.hitCondition,
              setter = function(v)
                bp.hitCondition = v
              end,
            },
            ["Log Message"] = {
              value = bp.logMessage,
              setter = function(v)
                bp.logMessage = v
              end,
            },
          }
          local menu_options = {}
          for k, v in pairs(props) do
            table.insert(menu_options, ("%s: %s"):format(k, v.value))
          end
          vim.ui.select(menu_options, {
            prompt = "Edit Breakpoint",
          }, function(choice)
            local prompt = (tostring(choice)):gsub(":.*", "")
            props[prompt].setter(vim.fn.input({
              prompt = prompt,
              default = props[prompt].value,
            }))

            -- Set breakpoint for current line, with customizations (see h:dap.set_breakpoint())
            dap.set_breakpoint(bp.condition, bp.hitCondition, bp.logMessage)
          end)
        end

        customize_bp(find_bp())
      end
      -- stylua: ignore
      local default_keys = {
        { "<leader>dB", edit_breakpoint, desc = "Breakpoint Condition" },
        { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() dap.continue() end, desc = "Run/Continue" },
        { "<leader>da", function() dap.continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() dap.run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() dap.goto_() end, desc = "Go to Line (No Execute)" },
        { "<leader>di", function() dap.step_into() end, desc = "Step Into" },
        { "<leader>dj", function() dap.down() end, desc = "Down" },
        { "<leader>dk", function() dap.up() end, desc = "Up" },
        { "<leader>dl", function() dap.run_last() end, desc = "Run Last" },
        { "<leader>do", function() dap.step_out() end, desc = "Step Out" },
        { "<leader>dO", function() dap.step_over() end, desc = "Step Over" },
        { "<leader>dP", function() dap.pause() end, desc = "Pause" },
        { "<leader>dr", function() dap.repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>ds", function() dap.session() end, desc = "Session" },
        { "<leader>dt", function() dap.terminate() end, desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      }
      return vim.tbl_deep_extend("force", default_keys, keys)
    end,

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
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
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
