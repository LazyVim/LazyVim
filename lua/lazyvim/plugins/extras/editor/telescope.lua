local extras = require("lazyvim.keymaps").get_keymaps().extras
local k = extras.editor.picker
local lang = extras.lang

if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "telescope"
end

local have_make = vim.fn.executable("make") == 1
local have_cmake = vim.fn.executable("cmake") == 1

---@type LazyPicker
local picker = {
  name = "telescope",
  commands = {
    files = "find_files",
  },
  -- this will return a function that calls telescope.
  -- cwd will default to lazyvim.util.get_root
  -- for `files`, git_files or find_files will be chosen depending on .git
  ---@param builtin string
  ---@param opts? lazyvim.util.pick.Opts
  open = function(builtin, opts)
    opts = opts or {}
    opts.follow = opts.follow ~= false
    if opts.cwd and opts.cwd ~= vim.uv.cwd() then
      local function open_cwd_dir()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick.open(
          builtin,
          vim.tbl_deep_extend("force", {}, opts or {}, {
            root = false,
            default_text = line,
          })
        )
      end
      ---@diagnostic disable-next-line: inject-field
      opts.attach_mappings = function(_, map)
        -- opts.desc is overridden by telescope, until it's changed there is this fix
        map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd Directory" })
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end,
}
if not LazyVim.pick.register(picker) then
  return {}
end

return {
  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    enabled = function()
      return LazyVim.pick.want() == "telescope"
    end,
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = have_make and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        enabled = have_make or have_cmake,
        config = function(plugin)
          LazyVim.on_load("telescope.nvim", function()
            local ok, err = pcall(require("telescope").load_extension, "fzf")
            if not ok then
              local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
              if not vim.uv.fs_stat(lib) then
                LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
                require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                  LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
                end)
              else
                LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
              end
            end
          end)
        end,
      },
    },
    keys = {
      {
        k.switch_buffer,
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { k.grep_root, LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { k.command_history, "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { k.find_files_root, LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      -- find
      { k.find_buffers, "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { k.find_config_file, LazyVim.pick.config_files(), desc = "Find Config File" },
      { k.find_files_root_alt, LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { k.find_files_cwd, LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { k.find_git_files, "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { k.find_recent_files, "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { k.find_files_cwd, LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      -- git
      { k.git_commits, "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { k.git_status, "<cmd>Telescope git_status<CR>", desc = "Status" },
      -- search
      { k.search_registers, "<cmd>Telescope registers<cr>", desc = "Registers" },
      { k.search_autocommands, "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { k.search_buffer, "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { k.search_command_history, "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { k.search_commands, "<cmd>Telescope commands<cr>", desc = "Commands" },
      { k.search_document_diagnostics, "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { k.search_workspace_diagnostics, "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { k.search_grep_root, LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { k.search_grep_cwd, LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { k.search_help_pages, "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { k.search_highlight_groups, "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { k.search_jumplist, "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { k.search_keymaps, "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { k.search_loclist, "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { k.search_man_pages, "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { k.search_marks, "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { k.search_options, "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { k.search_resume, "<cmd>Telescope resume<cr>", desc = "Resume" },
      { k.search_quickfix, "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
      { k.search_word_root, LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
      { k.search_word_cwd, LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
      { k.search_selection_root, LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
      { k.search_selection_cwd, LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
      {
        k.colorscheme_preview,
        LazyVim.pick("colorscheme", { enable_preview = true }),
        desc = "Colorscheme with Preview",
      },
      {
        k.go_to_symbol,
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = LazyVim.config.get_kind_filter(),
          })
        end,
        desc = "Goto Symbol",
      },
      {
        k.go_to_symbol_workspace,
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = LazyVim.config.get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.sources.telescope").open(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick("find_files", { hidden = true, default_text = line })()
      end

      local function find_command()
        if 1 == vim.fn.executable("rg") then
          return { "rg", "--files", "--color", "never", "-g", "!.git" }
        elseif 1 == vim.fn.executable("fd") then
          return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable("fdfind") then
          return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
          return { "find", ".", "-type", "f" }
        elseif 1 == vim.fn.executable("where") then
          return { "where", "/r", ".", "*" }
        end
      end

      local keymaps = {
        i = {
          { k.actions.open_with_trouble, open_with_trouble },
          { k.actions.open_with_trouble_alt, open_with_trouble },
          { k.actions.find_files_no_ignore, find_files_no_ignore },
          { k.actions.find_files_with_hidden, find_files_with_hidden },
          { k.actions.cycle_history_next, actions.cycle_history_next },
          { k.actions.cycle_history_prev, actions.cycle_history_prev },
          { k.actions.preview_scrolling_down, actions.preview_scrolling_down },
          { k.actions.preview_scrolling_up, actions.preview_scrolling_up },
        },
        n = {
          { k.actions.close, actions.close },
        },
      }
      local mappings = {
        i = {},
        n = {},
      }
      local function filter_keymaps(_keymaps, source)
        for _, keymap in ipairs(_keymaps) do
          if keymap[1] and keymap[1] ~= "" then
            source[keymap[1]] = keymap[2]
          end
        end
      end
      filter_keymaps(keymaps.i, mappings.i)
      filter_keymaps(keymaps.n, mappings.n)

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = mappings,
        },
        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
        },
      }
    end,
  },

  -- Flash Telescope config
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      if not LazyVim.has("flash.nvim") then
        return
      end
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          n = k.flash.normal == "" and {} or { [k.flash.normal] = flash },
          i = k.flash.insert == "" and {} or { [k.flash.insert] = flash },
        },
      })
    end,
  },

  -- better vim.ui with telescope
  {
    "stevearc/dressing.nvim",
    lazy = true,
    enabled = function()
      return LazyVim.pick.want() == "telescope"
    end,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      if LazyVim.pick.want() ~= "telescope" then
        return
      end
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { lang.go_to_definition, function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
        { lang.references, "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
        { lang.go_to_implementation, function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
        { lang.go_to_type_definition, function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
      })
    end,
  },
}
