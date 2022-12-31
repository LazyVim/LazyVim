vim.g.neo_tree_remove_legacy_commands = 1

return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = { { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" } },
    config = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
    },
    config = true,
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        show_help = false,
        plugins = { spelling = true },
        key_labels = { ["<leader>"] = "SPC" },
      })
      wk.register({
        f = { name = "+file" },
        g = { name = "+git" },
      }, { prefix = "<leader>" })
    end,
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end,
    keys = {
      {
        "]]",
        function()
          require("illuminate").goto_next_reference(false)
        end,
        desc = "Next Reference",
      },
      {
        "[[",
        function()
          require("illuminate").goto_prev_reference(false)
        end,
        desc = "Prev Reference",
      },
    },
  },
}
