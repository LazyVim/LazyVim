vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})
return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
      { "<leader>R", "", desc = "+Rest", ft = { "http", "rest" } },
      {
        "<leader>Rb",
        "<cmd>lua require('kulala').scratchpad()<cr>",
        desc = "Open scratchpad",
        ft = { "http", "rest" },
      },
      { "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL", ft = { "http", "rest" } },
      { "<leader>RC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from cURL", ft = { "http", "rest" } },
      {
        "<leader>Rg",
        "<cmd>lua require('kulala').download_graphql_schema()<cr>",
        desc = "Download GraphQL schema",
        ft = "http",
      },
      {
        "<leader>Ri",
        "<cmd>lua require('kulala').inspect()<cr>",
        desc = "Inspect current request",
        ft = { "http", "rest" },
      },
      { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request", ft = "http" },
      {
        "<leader>Rp",
        "<cmd>lua require('kulala').jump_prev()<cr>",
        desc = "Jump to previous request",
        ft = { "http", "rest" },
      },
      { "<leader>Rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window", ft = "http" },
      {
        "<leader>Rr",
        "<cmd>lua require('kulala').replay()<cr>",
        desc = "Replay the last request",
        ft = { "http", "rest" },
      },
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request", ft = { "http", "rest" } },
      { "<leader>RS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats", ft = { "http", "rest" } },
      {
        "<leader>Rt",
        "<cmd>lua require('kulala').toggle_view()<cr>",
        desc = "Toggle headers/body",
        ft = { "http", "rest" },
      },
    },
    opts = {
      ui = {
        icons = {
          inlay = {
            loading = "",
            done = "",
            error = "",
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "kulala-fmt",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        http = { "kulala-fmt" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "http", "graphql" },
    },
  },
}
