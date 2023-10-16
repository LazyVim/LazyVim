return {
  {
    "NTBBloodbath/zig-tools.nvim",
    ft = "zig",
    opts = {},
    dependencies = {
      {
        "akinsho/toggleterm.nvim",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "zig" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "zls", "codelldb" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        zls = {},
      },
    },
    setup = {
      zls = function(_, opts)
        local zig_tools_opts = require("lazyvim.util").opts("zig-tools.nvim")
        require("zig-tools").setup(vim.tbl_deep_extend("force", zig_tools_opts or {}, { server = opts }))
        return true
      end,
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "lawrence-laz/neotest-zig",
    },
    opts = {
      adapters = {
        ["neotest-zig"] = {},
      },
    },
  },
}
