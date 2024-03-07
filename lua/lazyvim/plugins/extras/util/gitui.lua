return {

  -- Ensure GitUI tool is installed
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>gG",
        function()
          require("lazyvim.util").terminal.open({ "gitui" }, { esc_esc = false, ctrl_hjkl = false })
        end,
        desc = "gitui (cwd)" },
      { "<leader>gg",
        function()
          require("lazyvim.util").terminal.open({ "gitui" }, { cwd = require("lazyvim.util").root.get(), esc_esc = false, ctrl_hjkl = false })
        end,
        desc = "gitui (root dir)" }
    },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gitui" })
    end,
  },
}
