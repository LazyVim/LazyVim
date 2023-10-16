return {
  {
    "NTBBloodbath/zig-tools.nvim",
    ft = "zig",
    opts = function(_, opts)
      require("zig-tools").setup(opts)
    end,
    dependencies = {
      {
        "akinsho/toggleterm.nvim",
      },
      {
        "nvim-lua/plenary.nvim",
        module_pattern = "plenary.*",
      },
    },
  },
  {
    "ziglang/zig.vim",
    lazy = false,
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
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["neotest-zig"] = {},
      },
    },
  },
}
