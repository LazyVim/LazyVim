return {
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "copilot",
      hints = {
        enabled = false,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua",
      { "echasnovski/mini.pick", optional = true }, -- for file_selector provider mini.pick
      { "nvim-telescope/telescope.nvim", optional = true }, -- for file_selector provider telescope
      { "hrsh7th/nvim-cmp", optional = true }, -- autocompletion for avante commands and mentions
      { "ibhagwan/fzf-lua", optional = true }, -- for file_selector provider fzf
      { "stevearc/dressing.nvim", optional = true }, -- for input provider dressing
      { "folke/snacks.nvim", optional = true }, -- for input provider snacks
      { "nvim-tree/nvim-web-devicons", optional = true }, -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        optional = true,
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "Kaiser-Yang/blink-cmp-avante",
        lazy = true,
        specs = {
          {
            "saghen/blink.cmp",
            optional = true,
            opts = {
              sources = {
                default = { "avante" },
                providers = { avante = { module = "blink-cmp-avante", name = "Avante" } },
              },
            },
          },
        },
      },
    },
  },
}
