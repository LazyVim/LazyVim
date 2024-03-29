return {
  { -- documentation generator
    "danymat/neogen",
    opts = { enabled = true },
    keys = {
      {
        "<leader>cnc",
        function()
          require("neogen").generate({ type = "class" })
        end,
        desc = "Generate documentation for class",
      },
      {
        "<leader>cnf",
        function()
          require("neogen").generate({ type = "func" })
        end,
        desc = "Generate documentation for function",
      },
      {
        "<leader>cnF",
        function()
          require("neogen").generate({ type = "file" })
        end,
        desc = "Generate documentation for file",
      },
      {
        "<leader>cnt",
        function()
          require("neogen").generate({ type = "type" })
        end,
        desc = "Generate documentation for type",
      },
    },
  },

  { -- which-key integration
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>cn"] = { name = "+neogen" },
      },
    },
  },
}
