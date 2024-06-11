vim.notify("Hello")
return {
  {
    -- highlighting for chezmoi files template files
    "alker0/chezmoi.vim",
    opts = {
      use_tmp_buffer = true,
      source_dir_path = os.getenv("HOME") .. "/.local/share/chezmoi",
    },
    config = function(_, opts)
      for key, value in pairs(opts) do
        vim.g["chezmoi#" .. key] = value
      end
    end,
  },
  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>sz",
        function()
          require("telescope").extensions.chezmoi.find_files()
        end,
        desc = "Chezmoi",
      },
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
    config = function(_, opts)
      require("chezmoi").setup(opts)
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      local projects = {
        action = "Telescope chezmoi find_files",
        desc = "  Config",
        icon = "",
        key = "c",
      }

      projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
      projects.key_format = "  %s"

      -- remove lazyvim config property
      for i = #opts.config.center, 1, -1 do
        if opts.config.center[i].key == "c" then
          table.remove(opts.config.center, i)
        end
      end

      table.insert(opts.config.center, 5, projects)
    end,
  },
}
