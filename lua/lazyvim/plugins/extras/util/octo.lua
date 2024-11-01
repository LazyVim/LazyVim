local k = require("lazyvim.keymaps").get_keymaps()

return {

  -- depends on the git extra for highlighting and auto-completion of github issues/prs
  { import = "lazyvim.plugins.extras.lang.git" },

  -- Octo
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      default_merge_method = "squash",
      picker = "telescope",
    },
    keys = {
      { k.octo_issue_list, "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
      { k.octo_issue_search, "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
      { k.octo_pr_list, "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { k.octo_pr_search, "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
      { k.octo_repo_list, "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
      { k.octo_search, "<cmd>Octo search<CR>", desc = "Search (Octo)" },

      { k.octo_assignee, "", desc = "+assignee (Octo)", ft = "octo" },
      { k.octo_comment_code, "", desc = "+comment/code (Octo)", ft = "octo" },
      { k.octo_label, "", desc = "+label (Octo)", ft = "octo" },
      { k.octo_issue, "", desc = "+issue (Octo)", ft = "octo" },
      { k.octo_react, "", desc = "+react (Octo)", ft = "octo" },
      { k.octo_pr, "", desc = "+pr (Octo)", ft = "octo" },
      { k.octo_review, "", desc = "+review (Octo)", ft = "octo" },
      { k.octo_insert_at, "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      { k.octo_insert_hashtag, "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
    },
  },

  -- Octo Picker
  {
    "pwntester/octo.nvim",
    opts = function(_, opts)
      vim.treesitter.language.register("markdown", "octo")
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
