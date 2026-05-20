if not vim.fn.executable("opencode") then
  vim.notify("opencode: binary not installed. See opencode.ai", vim.log.levels.ERROR)
  return {}
end

local function ask(prompt, opts)
  if not vim.fn.executable("opencode") then
    vim.notify("opencode: binary not installed. See opencode.ai", vim.log.levels.ERROR)
    return
  end
  require("opencode").ask(prompt, opts)
end

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
          require("opencode").toggle()
        end,
        mode = { "n" },
        desc = "Toggle OpenCode",
      },

      {
        "<leader>aq",
        function()
          require("opencode").stop()
        end,
        mode = { "n" },
        desc = "Stop/Close OpenCode",
      },

      {
        "<leader>as",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Select action",
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
      local opencode_cmd = "opencode --port"
      local snacks_terminal_opts = {
        win = {
          position = "right",
          on_win = function(win)
            -- Set up keymaps and cleanup for an arbitrary terminal
            require("opencode.terminal").setup(win.win)
          end,
          enter = false,
        },
        -- Otherwise, we get error `Terminal exited with code` when closing Opencode because
        -- the `stop` command already closes the terminal window, but the Snacks.terminal `TermClose`
        -- autocmd kicks in and tries to close it again, causing the error.
        auto_close = false,
      }

      config.opts = vim.tbl_deep_extend(
        "force",
        config.opts,
        {
          server = {
            start = function()
              require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
            end,
            stop = function()
              local win, created = require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts)
              if win and created then
                win:close()
                vim.cmd.stopinsert()
              elseif win and not created then
                win:close()
              end
            end,
            toggle = function()
              require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
            end,
          },
        },
        -- We merge here also `opts` so we can bypass the following limitation with `vim.g` https://github.com/nickjvandyke/opencode.nvim/issues/36
        opts or {},
        vim.g.opencode_opts or {}
      )

      vim.api.nvim_create_autocmd({ "TermOpen" }, {
        group = vim.api.nvim_create_augroup("opencode_integrated", { clear = true }),
        pattern = "*:opencode --port*",
        callback = function(event)
          vim.bo[event.buf].buflisted = false
          vim.bo[event.buf].filetype = "opencode"

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
        end,
      })
    end,
  },
}
