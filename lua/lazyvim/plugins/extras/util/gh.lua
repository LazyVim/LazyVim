return {

  -- depends on the git extra for highlighting and auto-completion of github issues/prs
  { import = "lazyvim.plugins.extras.lang.git" },

  { "ldelossa/litee.nvim", lazy = true },

  -- gh.nvim
  {
    "ldelossa/gh.nvim",
    opts = {},
    config = function(_, opts)
      require("litee.lib").setup()
      require("litee.gh").setup(opts)
    end,
    keys = {
      { "<leader>G", "", desc = "+Github" },
      { "<leader>Gc", "", desc = "+Commits" },
      { "<leader>Gcc", "<cmd>GHCloseCommit<cr>", desc = "Close" },
      { "<leader>Gce", "<cmd>GHExpandCommit<cr>", desc = "Expand" },
      { "<leader>Gco", "<cmd>GHOpenToCommit<cr>", desc = "Open To" },
      { "<leader>Gcp", "<cmd>GHPopOutCommit<cr>", desc = "Pop Out" },
      { "<leader>Gcz", "<cmd>GHCollapseCommit<cr>", desc = "Collapse" },
      { "<leader>Gi", "", desc = "+Issues" },
      { "<leader>Gip", "<cmd>GHPreviewIssue<cr>", desc = "Preview" },
      { "<leader>Gio", "<cmd>GHOpenIssue<cr>", desc = "Open" },
      { "<leader>Gl", "", desc = "+Litee" },
      { "<leader>Glt", "<cmd>LTPanel<cr>", desc = "Toggle Panel" },
      { "<leader>Gp", "", desc = "+Pull Request" },
      { "<leader>Gpc", "<cmd>GHClosePR<cr>", desc = "Close" },
      { "<leader>Gpd", "<cmd>GHPRDetails<cr>", desc = "Details" },
      { "<leader>Gpe", "<cmd>GHExpandPR<cr>", desc = "Expand" },
      { "<leader>Gpo", "<cmd>GHOpenPR<cr>", desc = "Open" },
      { "<leader>Gpp", "<cmd>GHPopOutPR<cr>", desc = "PopOut" },
      { "<leader>Gpr", "<cmd>GHRefreshPR<cr>", desc = "Refresh" },
      { "<leader>Gpt", "<cmd>GHOpenToPR<cr>", desc = "Open To" },
      { "<leader>Gpz", "<cmd>GHCollapsePR<cr>", desc = "Collapse" },
      { "<leader>Gr", "", desc = "+Review" },
      { "<leader>Grb", "<cmd>GHStartReview<cr>", desc = "Begin" },
      { "<leader>Grc", "<cmd>GHCloseReview<cr>", desc = "Close" },
      { "<leader>Grd", "<cmd>GHDeleteReview<cr>", desc = "Delete" },
      { "<leader>Gre", "<cmd>GHExpandReview<cr>", desc = "Expand" },
      { "<leader>Grs", "<cmd>GHSubmitReview<cr>", desc = "Submit" },
      { "<leader>Grz", "<cmd>GHCollapseReview<cr>", desc = "Collapse" },
      { "<leader>Gt", "", desc = "+Threads" },
      { "<leader>Gtc", "<cmd>GHCreateThread<cr>", desc = "Create" },
      { "<leader>Gtn", "<cmd>GHNextThread<cr>", desc = "Next" },
      { "<leader>Gtt", "<cmd>GHToggleThread<cr>", desc = "Toggle" },
    },
  },
}
