return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = "gpt-4",
        auto_insert_mode = true,
        show_help = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        separator = "---",
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    keys = {
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    init = function()
      LazyVim.on_load("which-key.nvim", function()
        vim.schedule(function()
          require("which-key").register({ a = { name = "+CopilotChat (AI)" } }, { prefix = "<leader>" })
        end)
      end)
    end,
    config = function(_, opts)
      local chat = require("CopilotChat")
      local ns = vim.api.nvim_create_namespace("copilot-chat-text-hl")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function(ev)
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false

          vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
            group = vim.api.nvim_create_augroup("copilot-chat-text-" .. ev.buf, { clear = true }),
            buffer = ev.buf,
            callback = function()
              vim.api.nvim_buf_clear_namespace(ev.buf, ns, 0, -1)
              local lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
              for l, line in ipairs(lines) do
                if line:match(opts.separator .. "$") then
                  local sep = vim.fn.strwidth(line) - vim.fn.strwidth(opts.separator)
                  vim.api.nvim_buf_set_extmark(ev.buf, ns, l - 1, sep, {
                    virt_text_win_col = sep,
                    virt_text = { { string.rep("─", vim.go.columns), "@punctuation.special.markdown" } },
                    priority = 100,
                  })
                  vim.api.nvim_buf_set_extmark(ev.buf, ns, l - 1, 0, {
                    end_col = sep + 1,
                    hl_group = "@markup.heading.2.markdown",
                    priority = 100,
                  })
                end
              end
            end,
          })
        end,
      })

      chat.setup(opts)
    end,
  },

  -- Telescope integration
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      -- Show help actions with telescope
      {
        "<leader>ad",
        function()
          local actions = require("CopilotChat.actions")
          local help = actions.help_actions()
          if not help then
            LazyVim.warn("No diagnostics found on the current line")
            return
          end
          require("CopilotChat.integrations.telescope").pick(help)
        end,
        desc = "Diagnostic Help (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
  },

  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "copilot-chat",
        title = "Copilot Chat",
        size = { width = 50 },
      })
    end,
  },
}
