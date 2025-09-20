return {

  -- depends on the git extra for highlighting and auto-completion of github issues/prs
  { import = "lazyvim.plugins.extras.lang.git" },

  -- gh.nvim
  {
    "ldelossa/gh.nvim",
    dependencies = {
      {
        "ldelossa/litee.nvim",
        config = function()
          require("litee.lib").setup()
        end,
      },
    },
    config = function()
      require("litee.gh").setup()
    end,
    keys = {
      { "<leader>gcc", "<cmd>GHCloseCommit<cr>", desc = "Close" },
      { "<leader>gce", "<cmd>GHExpandCommit<cr>", desc = "Expand" },
      { "<leader>gco", "<cmd>GHOpenToCommit<cr>", desc = "Open To" },
      { "<leader>gcp", "<cmd>GHPopOutCommit<cr>", desc = "Pop Out" },
      { "<leader>gcz", "<cmd>GHCollapseCommit<cr>", desc = "Collapse" },

      { "<leader>gpc", "<cmd>GHClosePR<cr>", desc = "Close" },
      { "<leader>gpd", "<cmd>GHPRDetails<cr>", desc = "Details" },
      { "<leader>gpe", "<cmd>GHExpandPR<cr>", desc = "Expand" },
      { "<leader>gpo", "<cmd>GHOpenPR<cr>", desc = "Open" },
      { "<leader>gpp", "<cmd>GHPopOutPR<cr>", desc = "Pop Out" },
      { "<leader>gpr", "<cmd>GHRefreshPR<cr>", desc = "Refresh" },
      { "<leader>gpt", "<cmd>GHOpenToPR<cr>", desc = "Open To" },
      { "<leader>gpz", "<cmd>GHCollapsePR<cr>", desc = "Collapse" },

      { "<leader>grb", "<cmd>GHStartReview<cr>", desc = "Begin" },
      { "<leader>grc", "<cmd>GHCloseReview<cr>", desc = "Close" },
      { "<leader>grd", "<cmd>GHDeleteReview<cr>", desc = "Delete" },
      { "<leader>gre", "<cmd>GHExpandReview<cr>", desc = "Expand" },
      { "<leader>grs", "<cmd>GHSubmitReview<cr>", desc = "Submit" },
      { "<leader>grz", "<cmd>GHCollapseReview<cr>", desc = "Collapse" },

      { "<leader>gtc", "<cmd>GHCreateThread<cr>", desc = "Create" },
      { "<leader>gtn", "<cmd>GHNextThread<cr>", desc = "Next" },
      { "<leader>gtt", "<cmd>GHToggleThread<cr>", desc = "Toggle" },

      { "<leader>ge", "<cmd>LTPanel<cr>", desc = "Toggle GitHub Panel" },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>gc", group = "commits", icon = { icon = "", color = "green" } },
        { "<leader>gp", group = "pr", icon = { icon = "", color = "green" } },
        { "<leader>gr", group = "review", icon = { icon = "", color = "green" } },
        { "<leader>gt", group = "threads", icon = { icon = "", color = "green" } },
        { "<leader>gi", "<cmd>GHOpenIssue<cr>", desc = "List Issues", icon = { icon = "", color = "green" } },
      },
    },
  },
}
