return {

  -- depends on the git extra for highlighting and auto-completion of github issues/prs
  { import = "lazyvim.plugins.extras.lang.git" },

  -- Octo
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    init = function()
      vim.treesitter.language.register("markdown", "octo")
    end,
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      default_merge_method = "squash",
      picker = "telescope",
    },
    keys = {
      { "<leader>gi", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
      { "<leader>gI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
      { "<leader>gp", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { "<leader>gP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
      { "<leader>gr", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
      { "<leader>gS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

      { "<leader>a", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<leader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<leader>l", "", desc = "+label (Octo)", ft = "octo" },
      { "<leader>i", "", desc = "+issue (Octo)", ft = "octo" },
      { "<leader>r", "", desc = "+react (Octo)", ft = "octo" },
      { "<leader>p", "", desc = "+pr (Octo)", ft = "octo" },
      { "<leader>v", "", desc = "+review (Octo)", ft = "octo" },
      { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
    },
  },

  -- Octo Picker
  {
    "pwntester/octo.nvim",
    opts = function(_, opts)
      if LazyVim.has("telescope.nvim") then
        opts.picker = "telescope"
      elseif LazyVim.has("fzf-lua") then
        opts.picker = "fzf-lua"
      else
        LazyVim.error("`octo.nvim` requires `telescope.nvim` or `fzf-lua`")
      end

      -- Keep some empty windows in sessions
      vim.api.nvim_create_autocmd("ExitPre", {
        group = vim.api.nvim_create_augroup("octo_exit_pre", { clear = true }),
        callback = function(ev)
          local keep = { "octo" }
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.tbl_contains(keep, vim.bo[buf].filetype) then
              vim.bo[buf].buftype = "" -- set buftype to empty to keep the window
            end
          end
        end,
      })
    end,
  },
}
