return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "haskell", "lhaskell" },
      root = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml" },
    })
  end,

  -- Add Haskell to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "haskell" } },
  },

  {
    "mrcjkb/haskell-tools.nvim",
    version = false,
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = {
      { "nvim-telescope/telescope.nvim", optional = true },
    },
    keys = {
      {
        "<leader>ce",
        ft = "haskell",
        "<cmd>HlsEvalAll<cr>",
        desc = "Haskell Evaluate All",
      },
      {
        "<leader>so",
        ft = "haskell",
        function()
          require("haskell-tools").hoogle.hoogle_signature()
        end,
        desc = "Hoogle (Function Signature)",
      },
      LazyVim.has("telescope.nvim") and {
        "<leader>sO",
        ft = "haskell",
        "<cmd>Telescope hoogle<cr>",
        desc = "Hoogle (Global)",
      } or nil,
      {
        "<leader>fl",
        ft = "haskell",
        function()
          require("haskell-tools").repl.toggle()
        end,
        desc = "GHCi REPL (Package)",
      },
      {
        "<leader>fL",
        ft = "haskell",
        function()
          require("haskell-tools").repl.toggle(vim.api.nvim_buf_get_name(0))
        end,
        desc = "GHCi REPL (Current File)",
      },
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("ht")
      end
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "haskell-language-server" } },
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "haskell-debug-adapter" } },
      },
    },
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      { "mrcjkb/neotest-haskell" },
    },
    opts = {
      adapters = {
        ["neotest-haskell"] = {},
      },
    },
  },

  {
    "mrcjkb/haskell-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip" },
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      local haskell_snippets = require("haskell-snippets").all
      require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
  },

  {
    "luc-tielen/telescope_hoogle",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = {
      { "nvim-telescope/telescope.nvim", optional = true },
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("hoogle")
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        haskell = { "fourmolu" },
        cabal = { "cabal_fmt" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        haskell = { "hlint" },
      },
    },
  },

  -- Make sure lspconfig doesn't start hls,
  -- as it conflicts with haskell-tools
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        hls = function()
          return true
        end,
      },
    },
  },
}
