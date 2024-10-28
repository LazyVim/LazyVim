local k = require("lazyvim.keymaps").get_keymaps().editor
local s = require("lazyvim.keymaps").get_keymaps().extras.coding.mini_surround

return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = function()
      return {
        {
          k.neo_tree.toggle_root,
          function()
            require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
          end,
          desc = "Explorer NeoTree (Root Dir)",
        },
        {
          k.neo_tree.toggle_cwd,
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        {
          k.neo_tree.toggle_root_alt,
          k.neo_tree.toggle_root,
          desc = "Explorer NeoTree (Root Dir)",
          remap = true,
        },
        {
          k.neo_tree.toggle_cwd_alt,
          k.neo_tree.toggle_cwd,
          desc = "Explorer NeoTree (cwd)",
          remap = true,
        },
        {
          k.neo_tree.toggle_git_status,
          function()
            require("neo-tree.command").execute({ source = "git_status", toggle = true })
          end,
          desc = "Git Explorer",
        },
        {
          k.neo_tree.toggle_buffers,
          function()
            require("neo-tree.command").execute({ source = "buffers", toggle = true })
          end,
          desc = "Buffer Explorer",
        },
      }
    end,
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = function()
      local neo_tree_mappings = {}
      local neo_tree_actions = {
        [k.neo_tree.window.open] = "open",
        [k.neo_tree.window.close_node] = "close_node",
        ["<space>"] = "none",
        [k.neo_tree.window.copy_path_to_clipboard] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
        [k.neo_tree.window.open_with_system_application] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
        [k.neo_tree.window.toggle_preview] = { "toggle_preview", config = { use_float = false } },
      }
      for key, value in pairs(neo_tree_actions) do
        if key and key ~= "" then
          neo_tree_mappings[key] = value
        end
      end

      return {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = neo_tree_mappings,
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          git_status = {
            symbols = {
              unstaged = "󰄱",
              staged = "󰱒",
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local function on_move(data)
        LazyVim.lsp.on_rename(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },

  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        k.grug_far.open,
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  -- Flash enhances the built-in search functionality by showing labels
  -- at the end of each match, letting you quickly jump to a specific
  -- location.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      {k.flash.jump, mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      {k.flash.treesitter, mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      {k.flash.remote, mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      {k.flash.treesitter_search, mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      {k.flash.toggle, mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { k.which_key.group.tabs, group = "tabs" },
          { k.which_key.group.code, group = "code" },
          { k.which_key.group.file_find, group = "file/find" },
          { k.which_key.group.git, group = "git" },
          { k.which_key.group.hunks, group = "hunks" },
          { k.which_key.group.quit_session, group = "quit/session" },
          { k.which_key.group.search, group = "search" },
          { k.which_key.group.ui, group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          {
            k.which_key.group.diagnostics_quickfix,
            group = "diagnostics/quickfix",
            icon = { icon = "󱖫 ", color = "green" },
          },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { s.prefix, group = "surround" },
          { "z", group = "fold" },
          k.which_key.group.buffer == "" and {} or {
            k.which_key.group.buffer,
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          k.which_key.group.windows == "" and {} or {
            k.which_key.group.windows,
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        k.which_key.buffer_keymaps,
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        k.which_key.window_hydra_mode,
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
        wk.register(opts.defaults)
      end
    end,
  },

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          LazyVim.keymap_set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", k.gitsigns.next_hunk, function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", k.gitsigns.prev_hunk, function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", k.gitsigns.last_hunk, function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", k.gitsigns.first_hunk, function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, k.gitsigns.stage_hunk, ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, k.gitsigns.reset_hunk, ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", k.gitsigns.stage_buffer, gs.stage_buffer, "Stage Buffer")
        map("n", k.gitsigns.undo_stage_hunk, gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", k.gitsigns.reset_buffer, gs.reset_buffer, "Reset Buffer")
        map("n", k.gitsigns.preview_hunk_inline, gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", k.gitsigns.blame_line, function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", k.gitsigns.blame_buffer, function() gs.blame() end, "Blame Buffer")
        map("n", k.gitsigns.diff_index, gs.diffthis, "Diff This")
        map("n", k.gitsigns.diff_commit, function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, k.gitsigns.select_hunk, ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { k.trouble.diagnostics_toggle, "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      {
        k.trouble.diagnostics_buffer_toggle,
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      { k.trouble.symbols_toggle, "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { k.trouble.lsp_toggle, "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { k.trouble.loclist_toggle, "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { k.trouble.qflist_toggle, "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        k.trouble.previous_trouble,
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        k.trouble.next_trouble,
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    opts = {},
    -- stylua: ignore
    keys = {
      { k.todo_comments.next_todo, function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { k.todo_comments.prev_todo, function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { k.todo_comments.todo_trouble, "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { k.todo_comments.todo_fix_fixme_trouble, "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { k.todo_comments.todo_telescope, "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { k.todo_comments.todo_fix_fixme_telescope, "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  {
    import = "lazyvim.plugins.extras.editor.fzf",
    enabled = function()
      return LazyVim.pick.want() == "fzf"
    end,
  },
  {
    import = "lazyvim.plugins.extras.editor.telescope",
    enabled = function()
      return LazyVim.pick.want() == "telescope"
    end,
  },
}
