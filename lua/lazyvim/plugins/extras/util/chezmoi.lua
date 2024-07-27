-- exclude directories and externals
local chezmoi_list_args = { "--include", "files", "--exclude", "externals" }

---@param targets? string|string[]
local function fzf_chezmoi(targets)
  local fzf_lua = require("fzf-lua")
  local chezmoi = require("chezmoi.commands")
  local results = chezmoi.list({
    targets = targets or {},
    args = chezmoi_list_args,
  })
  local opts = {
    fzf_opts = {},
    fzf_colors = true,
    actions = {
      ["default"] = function(selected)
        if not vim.tbl_isempty(selected) then
          chezmoi.edit({
            targets = "~/" .. selected[1],
          })
        end
      end,
    },
  }
  fzf_lua.fzf_exec(results, opts)
end

local pick_chezmoi = function()
  if LazyVim.pick.picker.name == "telescope" then
    require("telescope").extensions.chezmoi.find_files()
  elseif LazyVim.pick.picker.name == "fzf" then
    fzf_chezmoi()
  end
end

--- pick nvim config
local pick_config = function()
  local chezmoi = require("chezmoi.commands")
  local config_dir = vim.fn.stdpath("config")
  local managed_config_files = chezmoi.list({
    targets = config_dir,
    args = { "--path-style", "absolute", unpack(chezmoi_list_args) },
  })

  if vim.tbl_isempty(managed_config_files) then
    LazyVim.pick.config_files()()
    return
  end

  if LazyVim.pick.picker.name == "telescope" then
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local config = require("chezmoi").config

    require("telescope.builtin").find_files({
      prompt_title = "Config Files",
      cwd = config_dir,
      attach_mappings = function(prompt_bufnr, map)
        local edit_action = function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            chezmoi.edit({
              targets = config_dir .. "/" .. selection.value,
            })
          end
        end

        for _, v in ipairs(config.telescope.select) do
          map("i", v, "select_default")
        end

        -- it's possible that only part of nvim config files are managed with chezmoi
        -- pick all and just edit if unmanaged
        actions.select_default:replace_if(function()
          local selection = action_state.get_selected_entry()
          return selection and vim.tbl_contains(managed_config_files, config_dir .. "/" .. selection.value)
        end, edit_action)
        return true
      end,
    })
  elseif LazyVim.pick.picker.name == "fzf" then
    -- only pick the managed config files
    fzf_chezmoi(config_dir)
  end
end

return {
  {
    -- highlighting for chezmoi files template files
    "alker0/chezmoi.vim",
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmoi"
    end,
  },
  {
    "xvzc/chezmoi.nvim",
    keys = {
      { "<leader>sz", pick_chezmoi, desc = "Chezmoi" },
      { "<leader>fc", pick_config, desc = "Find Config File" },
    },
    opts = {
      edit = {
        watch = false,
        force = false,
      },
      notification = {
        on_open = true,
        on_apply = true,
        on_watch = false,
      },
      telescope = {
        select = { "<CR>" },
      },
    },
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
        callback = function()
          vim.schedule(require("chezmoi.commands.__edit").watch)
        end,
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = { { "<leader>fc", false } },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = { { "<leader>fc", false } },
  },

  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      local chezmoi = {
        action = pick_chezmoi,
        desc = "  Config",
        icon = "",
        key = "c",
      }

      chezmoi.desc = chezmoi.desc .. string.rep(" ", 43 - #chezmoi.desc)
      chezmoi.key_format = "  %s"

      -- remove lazyvim config property
      for i = #opts.config.center, 1, -1 do
        if opts.config.center[i].key == "c" then
          table.remove(opts.config.center, i)
        end
      end

      table.insert(opts.config.center, 5, chezmoi)
    end,
  },

  -- Filetype icons
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
        ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
        ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
      },
    },
  },
}
