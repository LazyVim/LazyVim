return {
  {
    "lukas-reineke/headlines.nvim",
    enabled = false,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    event = "BufEnter",
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown Render" },
    },
    opts = {
      code = {
        sign = false,
      },
      heading = {
        sign = false,
        backgrounds = {
          "Headline1",
          "Headline2",
          "Headline3",
          "Headline4",
          "Headline5",
          "Headline6",
        },
      },
    },
  },
}
