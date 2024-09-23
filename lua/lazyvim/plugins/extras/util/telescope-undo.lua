return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = {
      {
        "debugloop/telescope-undo.nvim",
        keys = {
          {
            "<leader>fu",
            "<cmd>Telescope undo<cr>",
            desc = "Undo history",
          },
        },
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("undo")
          end)
        end,
      },
    },
  },
}
