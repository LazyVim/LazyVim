if not vim.fn.executable("opencode") then
  vim.notify("opencode: binary not installed. See opencode.ai", vim.log.levels.ERROR)
  return {}
end

local opencode_cmd = "opencode --port"

local function ask(prompt, opts)
  if not vim.fn.executable("opencode") then
    vim.notify("opencode: binary not installed. See opencode.ai", vim.log.levels.ERROR)
    return
  end
  require("opencode").ask(prompt, opts)
end

local snacks_terminal_opts = {
  win = {
    position = "right",
    width = 0.40,
    enter = false,
  },
  auto_close = false,
}

return {
  -- which-key
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, { "<leader>a", group = "OpenCode" })
      table.insert(opts.spec, { "<leader>ag", group = "git" })
      table.insert(opts.spec, { "<leader>ap", group = "prompt" })
    end,
  },

  {
    "Nickvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "OpenCode", "OpenCodeToggle" },
    keys = {
      { "gO", false },
      {
        "<leader>aa",
        function()
          snacks_terminal_opts = vim.tbl_deep_extend(
            "force",
            snacks_terminal_opts,
            LazyVim.opts("opencode.nvim").snacks_terminal_opts or {},
            vim.g.opencode_opts and vim.g.opencode_opts.snacks_terminal_opts or {}
          )
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
        desc = "Toggle OpenCode",
        mode = "n",
      },
      {
        "<leader>aq",
        function()
          -- Directly fetches your active snacks instance running OpenCode
          local win = require("snacks.terminal").get("opencode --port", { create = false })
          if win then
            -- Formally kills the underlying terminal shell process job
            if win.opts and win.opts.id then
              vim.fn.jobstop(win.opts.id)
            end
            -- Gracefully closes out the split pane
            win:close()
            vim.cmd.stopinsert()
            vim.notify("OpenCode process and terminal terminated cleanly.", vim.log.levels.INFO)
          else
            vim.notify("No active OpenCode process found to stop.", vim.log.levels.WARN)
          end
        end,
        desc = "Stop/Kill OpenCode Instance",
        mode = "n",
      },
      {
        "<leader>as",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Opencode Command Palette: Select Action",
      },

      {
        "<leader>ai",
        function()
          ask("", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Ask (empty)",
      },

      {
        "<leader>aI",
        function()
          ask("@this: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Ask with context",
      },

      {
        "<leader>ab",
        function()
          ask("@buffer ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Ask about buffer",
      },

      {
        "<leader>agd",
        function()
          ask("@diff ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Git diff",
      },

      {
        "<leader>ax",
        function()
          ask("@quickfix ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Ask with quickfix",
      },

      {
        "<leader>av",
        function()
          ask("@visible ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Ask with visible text",
      },

      {
        "<leader>aB",
        function()
          ask("@buffers ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Ask with all buffers",
      },

      {
        "<leader>am",
        function()
          ask("@marks ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Ask with marks",
      },

      {
        "<leader>ape",
        function()
          ask("@this explain: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Explain",
      },

      {
        "<leader>apf",
        function()
          ask("@this fix: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Fix",
      },

      {
        "<leader>apd",
        function()
          ask("@this diagnose: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Diagnose",
      },

      {
        "<leader>apr",
        function()
          ask("@this review: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Review",
      },

      {
        "<leader>apt",
        function()
          ask("@this test: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Test",
      },

      {
        "<leader>apo",
        function()
          ask("@this optimize: ", { submit = true, focus = false })
        end,
        mode = { "n", "x" },
        desc = "Optimize",
      },

      {
        "<leader>an",
        function()
          require("opencode").command("session.new")
        end,
        mode = { "n" },
        desc = "New session",
      },

      {
        "<leader>ac",
        function()
          require("opencode").command("session.close")
        end,
        mode = { "n" },
        desc = "Close session",
      },

      {
        "go",
        function()
          return require("opencode").operator("@this ")
        end,
        expr = true,
        mode = { "n", "x" },
        desc = "Add range to OpenCode",
      },

      {
        "goo",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        expr = true,
        mode = { "n" },
        desc = "Add line to OpenCode",
      },
    },
    config = function(_, opts)
      local config = require("opencode.config")

      snacks_terminal_opts = vim.tbl_deep_extend(
        "force",
        snacks_terminal_opts,
        LazyVim.opts("opencode.nvim").snacks_terminal_opts or {},
        vim.g.opencode_opts and vim.g.opencode_opts.snacks_terminal_opts or {}
      )

      -- Custom server process hooks safely
      config.opts = vim.tbl_deep_extend("force", config.opts, {
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
          end,
        },
      }, opts or {}, vim.g.opencode_opts or {})

      -- Enable auto-reveal window feature
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("opencode_reveal", { clear = true }),
        pattern = { "OpencodeEvent:tui.command.execute" },
        callback = function(args)
          ---@type opencode.server.Event
          local event = args.data.event
          if event.properties.command == "prompt.submit" then
            local win = require("snacks.terminal").get(opencode_cmd, { create = false })
            if win then
              win:show()
            end
          end
        end,
      })

      -- Retain localized scrolling maps without causing input lag
      vim.api.nvim_create_autocmd({ "TermOpen" }, {
        group = vim.api.nvim_create_augroup("opencode_integrated", { clear = true }),
        pattern = "*:opencode --port*",
        callback = function(event)
          vim.bo[event.buf].buflisted = false
          vim.bo[event.buf].filetype = "opencode"

          -- Opencode Command Palette
          vim.keymap.set("t", "<M-s>", function()
            -- Drops out of terminal mode momentarily to trigger the native Neovim/Snacks picker
            vim.cmd.stopinsert()
            require("opencode").select()
          end, { buffer = event.buf, desc = "OpenCode Command Palette" })

          -- Scroll Mappings
          vim.keymap.set("t", "<C-U>", function()
            require("opencode").command("session.half.page.up")
          end, { buffer = event.buf, desc = "Half scroll back" })
          vim.keymap.set("t", "<C-D>", function()
            require("opencode").command("session.half.page.down")
          end, { buffer = event.buf, desc = "Half scroll forward" })
          vim.keymap.set("t", "<C-B>", function()
            require("opencode").command("session.page.up")
          end, { buffer = event.buf, desc = "Scroll backward" })
          vim.keymap.set("t", "<C-F>", function()
            require("opencode").command("session.page.down")
          end, { buffer = event.buf, desc = "Scroll forward" })

          -- Rapid Chat Jumps
          vim.keymap.set("t", "<M-g>", function()
            require("opencode").command("session.first")
          end, { buffer = event.buf, desc = "Jump to first chat message" })
          vim.keymap.set("t", "<M-G>", function()
            require("opencode").command("session.last")
          end, { buffer = event.buf, desc = "Jump to last chat message" })

          -- Prompt Processing
          vim.keymap.set("t", "<M-CR>", function()
            require("opencode").command("prompt.submit")
          end, { buffer = event.buf, desc = "Submit active prompt" })
          vim.keymap.set("t", "<M-c>", function()
            require("opencode").command("prompt.clear")
          end, { buffer = event.buf, desc = "Clear active prompt input" })
          vim.keymap.set("t", "<M-x>", function()
            require("opencode").command("session.interrupt")
          end, { buffer = event.buf, desc = "Interrupt ongoing response" })

          -- Chat Workspace Lifecycles
          vim.keymap.set("t", "<M-n>", function()
            require("opencode").command("session.new")
          end, { buffer = event.buf, desc = "Open a new session context" })
          vim.keymap.set("t", "<M-z>", function()
            require("opencode").command("session.undo")
          end, { buffer = event.buf, desc = "Undo last chat action" })
          vim.keymap.set("t", "<M-y>", function()
            require("opencode").command("session.redo")
          end, { buffer = event.buf, desc = "Redo last chat action" })
          vim.keymap.set("t", "<M-a>", function()
            require("opencode").command("agent.cycle")
          end, { buffer = event.buf, desc = "Cycle active subagent model" })
        end,
      })
    end,
  },
}
