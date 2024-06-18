local pick = nil

pick = function()
  if LazyVim.pick.picker.name == "telescope" then
    return vim.cmd("Telescope projects")
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local project = require("project_nvim.project")
    local history = require("project_nvim.utils.history")
    local results = history.get_recent_projects()
    local actions = require("fzf-lua.actions")
    local core = require("fzf-lua.core")
    -- local path = require("fzf-lua.path")
    local utils = require("fzf-lua.utils")

    local function hl_validate(hl)
      return not utils.is_hl_cleared(hl) and hl or nil
    end

    function actions.project_files(selected)
      fzf_lua.files({ cwd = selected[1] })
    end

    function actions.project_live_grep(selected)
      fzf_lua.live_grep({ cwd = selected[1] })
    end

    function actions.project_oldfiles(selected)
      fzf_lua.oldfiles({ cwd = selected[1] })
    end

    function actions.project_cd_cwd(selected)
      local path = selected[1]
      local ok = project.set_pwd(path)
      if ok then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        LazyVim.info("Change project dir to " .. path)
      end
    end

    function actions.project_delete(selected)
      local path = selected[1]
      local choice = vim.fn.confirm("Delete '" .. path .. "' project? ", "&Yes\n&No")
      if choice == 1 then
        history.delete_project({ value = path })
      end
      pick()
    end

    -- core.ACTION_DEFINITIONS[actions.project_files] = { "find project files" }
    core.ACTION_DEFINITIONS[actions.file_tabedit] = { "tabedit" }
    core.ACTION_DEFINITIONS[actions.project_live_grep] = { "live_grep" }
    core.ACTION_DEFINITIONS[actions.project_oldfiles] = { "oldfiles" }
    core.ACTION_DEFINITIONS[actions.project_cd_cwd] = { "change dir" }
    core.ACTION_DEFINITIONS[actions.project_delete] = { "delete" }

    local opts = {
      fzf_opts = {},
      hls = {
        header_bind = hl_validate("FzfLuaHeaderBind"),
        header_text = hl_validate("FzfLuaHeaderText"),
      },
      fzf_colors = true,
      header_separator = " | ",
      actions = {
        ["default"] = actions.project_files,
        ["ctrl-t"] = actions.file_tabedit,
        ["ctrl-s"] = actions.project_live_grep,
        ["ctrl-r"] = actions.project_oldfiles,
        ["ctrl-w"] = actions.project_cd_cwd,
        ["ctrl-d"] = actions.project_delete,
      },
    }

    opts = core.set_header(opts, { "actions" })
    fzf_lua.fzf_exec(results, opts)
  end
end

return {
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = true,
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
    },
  },

  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
    },
  },

  {
    "goolord/alpha-nvim",
    optional = true,
    opts = function(_, dashboard)
      local button = dashboard.button("p", " " .. " Projects", pick)
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      table.insert(dashboard.section.buttons.val, 4, button)
    end,
  },

  {
    "echasnovski/mini.starter",
    optional = true,
    opts = function(_, opts)
      local items = {
        {
          name = "Projects",
          action = pick,
          section = string.rep(" ", 22) .. "Telescope",
        },
      }
      vim.list_extend(opts.items, items)
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      local projects = {
        action = pick,
        desc = " Projects",
        icon = " ",
        key = "p",
      }

      projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
      projects.key_format = "  %s"

      table.insert(opts.config.center, 3, projects)
    end,
  },
}
