local k = require("lazyvim.keymaps").get_keymaps().extras.editor.picker
local lang = require("lazyvim.keymaps").get_keymaps().extras.lang
local t = require("lazyvim.keymaps").get_keymaps().editor.todo_comments

if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "fzf"
end

---@class FzfLuaOpts: lazyvim.util.pick.Opts
---@field cmd string?

---@type LazyPicker
local picker = {
  name = "fzf",
  commands = {
    files = "files",
  },

  ---@param command string
  ---@param opts? FzfLuaOpts
  open = function(command, opts)
    opts = opts or {}
    if opts.cmd == nil and command == "git_files" and opts.show_untracked then
      opts.cmd = "git ls-files --exclude-standard --cached --others"
    end
    return require("fzf-lua")[command](opts)
  end,
}
if not LazyVim.pick.register(picker) then
  return {}
end

local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
  desc = "Awesome picker for FZF (alternative to Telescope)",
  recommended = true,
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      local config = require("fzf-lua.config")
      local actions = require("fzf-lua.actions")

      -- Quickfix
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
      config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

      -- Trouble
      if LazyVim.has("trouble.nvim") then
        config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
      end

      -- Toggle root dir / cwd
      config.defaults.actions.files["ctrl-r"] = function(_, ctx)
        local o = vim.deepcopy(ctx.__call_opts)
        o.root = o.root == false
        o.cwd = nil
        o.buf = ctx.__CTX.bufnr
        LazyVim.pick.open(ctx.__INFO.cmd, o)
      end
      config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
      config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

      -- use the same prompt for all
      local defaults = require("fzf-lua.profiles.default-title")
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
      end
      fix(defaults)

      local img_previewer ---@type string[]?
      for _, v in ipairs({
        { cmd = "ueberzug", args = {} },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
        { cmd = "viu", args = { "-b" } },
      }) do
        if vim.fn.executable(v.cmd) == 1 then
          img_previewer = vim.list_extend({ v.cmd }, v.args)
          break
        end
      end

      local default_keymaps = {
        [k.actions.find_files_no_ignore] = { actions.toggle_ignore },
        [k.actions.find_files_with_hidden] = { actions.toggle_hidden },
      }
      local keymaps = {}

      for key, value in pairs(default_keymaps) do
        if key and key ~= "" then
          keymaps[key] = value
        end
      end

      return vim.tbl_deep_extend("force", defaults, {
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        defaults = {
          -- formatter = "path.filename_first",
          formatter = "path.dirname_first",
        },
        previewers = {
          builtin = {
            extensions = {
              ["png"] = img_previewer,
              ["jpg"] = img_previewer,
              ["jpeg"] = img_previewer,
              ["gif"] = img_previewer,
              ["webp"] = img_previewer,
            },
            ueberzug_scaler = "fit_contain",
          },
        },
        -- Custom LazyVim option to configure vim.ui.select
        ui_select = function(fzf_opts, items)
          return vim.tbl_deep_extend("force", fzf_opts, {
            prompt = " ",
            winopts = {
              title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
              title_pos = "center",
            },
          }, fzf_opts.kind == "codeaction" and {
            winopts = {
              layout = "vertical",
              -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
              width = 0.5,
              preview = not vim.tbl_isempty(LazyVim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
                layout = "vertical",
                vertical = "down:15,border-top",
                hidden = "hidden",
              } or {
                layout = "vertical",
                vertical = "down:15,border-top",
              },
            },
          } or {
            winopts = {
              width = 0.5,
              -- height is number of items, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
            },
          })
        end,
        winopts = {
          width = 0.8,
          height = 0.8,
          row = 0.5,
          col = 0.5,
          preview = {
            scrollchars = { "┃", "" },
          },
        },
        files = {
          cwd_prompt = false,
          actions = keymaps,
        },
        grep = {
          actions = keymaps,
        },
        lsp = {
          symbols = {
            symbol_hl = function(s)
              return "TroubleIcon" .. s
            end,
            symbol_fmt = function(s)
              return s:lower() .. "\t"
            end,
            child_prefix = false,
          },
          code_actions = {
            previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
          },
        },
      })
    end,
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
    init = function()
      LazyVim.on_very_lazy(function()
        vim.ui.select = function(...)
          require("lazy").load({ plugins = { "fzf-lua" } })
          local opts = LazyVim.opts("fzf-lua") or {}
          require("fzf-lua").register_ui_select(opts.ui_select or nil)
          return vim.ui.select(...)
        end
      end)
    end,
    keys = {
      { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
      {
        k.switch_buffer,
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { k.grep_root, LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { k.command_history, "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { k.find_files_root, LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      -- find
      { k.find_buffers, "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { k.find_config_file, LazyVim.pick.config_files(), desc = "Find Config File" },
      { k.find_files_root_alt, LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { k.find_files_cwd, LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { k.find_git_files, "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
      { k.find_recent_files, "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { k.find_recent_files_cwd, LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      -- git
      { k.git_commits, "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
      { k.git_status, "<cmd>FzfLua git_status<CR>", desc = "Status" },
      -- search
      { k.search_registers, "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { k.search_autocommands, "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { k.search_buffer, "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      { k.search_command_history, "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { k.search_commands, "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { k.search_document_diagnostics, "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      { k.search_workspace_diagnostics, "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      { k.search_grep_root, LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { k.search_grep_cwd, LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { k.search_help_pages, "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { k.search_highlight_groups, "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { k.search_jumplist, "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      { k.search_keymaps, "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { k.search_loclist, "<cmd>FzfLua loclist<cr>", desc = "Location List" },
      { k.search_man_pages, "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { k.search_marks, "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { k.search_resume, "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { k.search_quickfix, "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      { k.search_word_root, LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
      { k.search_word_cwd, LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
      { k.search_selection_root, LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
      { k.search_selection_cwd, LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
      { k.colorscheme_preview, LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
      {
        k.go_to_symbol,
        function()
          require("fzf-lua").lsp_document_symbols({
            regex_filter = symbols_filter,
          })
        end,
        desc = "Goto Symbol",
      },
      {
        k.go_to_symbol_workspace,
        function()
          require("fzf-lua").lsp_live_workspace_symbols({
            regex_filter = symbols_filter,
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { t.todo_telescope, function() require("todo-comments.fzf").todo() end, desc = "Todo" },
      { t.todo_fix_fixme_telescope, function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { lang.go_to_definition, "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Definition", has = "definition" },
        { lang.references, "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>", desc = "References", nowait = true },
        { lang.go_to_implementation, "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
        { lang.go_to_type_definition, "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
      })
    end,
  },
}
