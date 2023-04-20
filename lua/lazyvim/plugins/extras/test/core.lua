return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      -- which key integration
      {
        "folke/which-key.nvim",
        opts = {
          defaults = {
            ["<leader>t"] = { name = "+test" },
          },
        },
      },
    },
    config = function(_, opts)
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      local group = vim.api.nvim_create_augroup("lazyvim_neotest_close_with_q", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = {
          "neotest-output",
        },
        callback = function(event)
          vim.bo[event.buf].buflisted = false
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end,
      })

      require("neotest").setup(opts)
    end,
    -- stylua: ignore
    keys = {
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tR", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
  },
}
