local function safe_ask(prompt, opts)
  if not vim.fn.executable("opencode") then
    vim.notify("opencode: binary not installed. See opencode.ai", vim.log.levels.ERROR)
    return
  end
  require("opencode").ask(prompt, opts)
end

local function focus_opencode()
  vim.schedule(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.api.nvim_buf_get_name(buf):match("opencode %-%-port") then
        vim.api.nvim_set_current_win(win)
      end
    end
  end)
end

return {
  recommended = true,

  -- which-key
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, { "<leader>a", group = "OpenCode" })
      table.insert(opts.spec, { "<leader>ag", group = "git" })
      table.insert(opts.spec, { "<leader>ax", group = "diagnostics/quickfix" })
      if LazyVim.has("grapple.nvim") then
        table.insert(opts.spec, { "<leader>af", group = "grapple" })
      end
      table.insert(opts.spec, { "<leader>ap", group = "prompt" })
    end,
  },

  {
    "folke/snacks.nvim",
  },

  {
    "Nickvandyke/opencode.nvim",
    version = "*",
    cmd = "OpenCode",
    keys = function()
      local keys = {
        { "gO", false },
        {
          "<leader>aa",
          function()
            require("opencode").toggle()
            focus_opencode()
          end,
          mode = { "n", "t" },
          desc = "Toggle OpenCode",
        },
        {
          "<leader>aq",
          function()
            require("opencode").stop()
          end,
          mode = { "n", "t" },
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
            safe_ask("", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask (empty)",
        },
        {
          "<leader>aI",
          function()
            safe_ask("@this: ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask with context",
        },
        {
          "<leader>ab",
          function()
            safe_ask("@buffer ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask about buffer",
        },
        {
          "<leader>agd",
          function()
            safe_ask("@diff ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Git diff",
        },
        {
          "<leader>ax",
          group = "diagnostics/quickfix",
        },
        {
          "<leader>axx",
          function()
            safe_ask("@quickfix ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask with quickfix",
        },
        {
          "<leader>axd",
          function()
            safe_ask("@diagnostics ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask with diagnostics",
        },
        {
          "<leader>av",
          function()
            safe_ask("@visible ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask with visible text",
        },
        {
          "<leader>aB",
          function()
            safe_ask("@buffers ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask with all buffers",
        },
        {
          "<leader>am",
          function()
            safe_ask("@marks ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask with marks",
        },
        {
          "<leader>ape",
          function()
            safe_ask("@this explain: ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Explain",
        },
        {
          "<leader>apf",
          function()
            safe_ask("@this fix: ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Fix",
        },
        {
          "<leader>apd",
          function()
            safe_ask("@this diagnose: ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Diagnose",
        },
        {
          "<leader>apr",
          function()
            safe_ask("@this review: ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Review",
        },
        {
          "<leader>apt",
          function()
            safe_ask("@this test: ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Test",
        },
        {
          "<leader>apo",
          function()
            safe_ask("@this optimize: ", { submit = true, focus = false })
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
      }

      if LazyVim.has("grapple.nvim") then
        table.insert(keys, {
          "<leader>af",
          function()
            safe_ask("@grapple ", { submit = true, focus = false })
          end,
          mode = { "n", "x" },
          desc = "Ask with grapple",
        })
      end

      return keys
    end,
    config = function()
      vim.g.opencode_opts = {}

      -- Fix for marksman crashing on opencode buffers
      vim.api.nvim_create_autocmd({ "BufAdd", "BufWinEnter", "TermOpen" }, {
        callback = function(event)
          if vim.api.nvim_buf_get_name(event.buf):match("opencode") then
            vim.bo[event.buf].filetype = "opencode"
            vim.b[event.buf].lsp_ignore = true
            -- Detach any clients that might have already attached
            local clients = vim.lsp.get_clients({ bufnr = event.buf })
            for _, client in ipairs(clients) do
              vim.lsp.buf_detach_client(event.buf, client.id)
            end
          end
        end,
      })

      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = "*:opencode --port*",
        callback = function()
          vim.cmd("startinsert")
        end,
      })

      vim.api.nvim_create_autocmd({ "TermOpen" }, {
        group = vim.api.nvim_create_augroup("opencode_integrated", { clear = true }),
        pattern = "*:opencode --port*",
        callback = function(event)
          vim.bo[event.buf].buflisted = false
          vim.bo[event.buf].filetype = "opencode"

          vim.keymap.set({ "t", "n" }, "<C-h>", "<C-\\><C-n><C-w>h", { buffer = event.buf, desc = "Go to Left Window" })
          vim.keymap.set(
            { "t", "n" },
            "<C-j>",
            "<C-\\><C-n><C-w>j",
            { buffer = event.buf, desc = "Go to Lower Window" }
          )
          vim.keymap.set(
            { "t", "n" },
            "<C-k>",
            "<C-\\><C-n><C-w>k",
            { buffer = event.buf, desc = "Go to Upper Window" }
          )
          vim.keymap.set(
            { "t", "n" },
            "<C-l>",
            "<C-\\><C-n><C-w>l",
            { buffer = event.buf, desc = "Go to Right Window" }
          )
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

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          if vim.fn.has("unix") == 1 then
            local pid = vim.fn.getpid()
            vim.fn.system({ "pkill", "-P", tostring(pid), "-f", "opencode" })
          end
        end,
      })
    end,
  },
}
