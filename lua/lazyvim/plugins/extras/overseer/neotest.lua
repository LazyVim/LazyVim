return {
  "nvim-neotest/neotest",
  dependencies = "stevearc/overseer.nvim",
  opts = {
    consumers = {
      overseer = require("neotest.consumers.overseer"),
    },
  },
}
