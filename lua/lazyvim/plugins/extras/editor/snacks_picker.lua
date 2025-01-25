if lazyvim_docs then
  -- In case you don't want to use `:LazyExtras`,
  -- then you need to set the option below.
  vim.g.lazyvim_picker = "snacks"
end

---@module 'snacks'

---@type LazyPicker
local picker = {
  name = "snacks",
  commands = {
    files = "files",
    live_grep = "grep",
    oldfiles = "recent",
  },

  ---@param source string
  ---@param opts? snacks.picker.Config
  open = function(source, opts)
    return Snacks.picker.pick(source, opts)
  end,
}
if not LazyVim.pick.register(picker) then
  return {}
end

return {
  desc = "Fast and modern file picker",
  recommended = true,
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<a-c>"] = {
                "toggle_cwd",
                mode = { "n", "i" },
              },
            },
          },
        },
        actions = {
          ---@param p snacks.Picker
          toggle_cwd = function(p)
            local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
            local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
            local current = p:cwd()
            p:set_cwd(current == root and cwd or root)
            p:find()
          end,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
      { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
      { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
      { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent" },
      { "<leader>fR", LazyVim.pick("oldfiles", { filter = { cwd = true }}), desc = "Recent (cwd)" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      -- git
      { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      { "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
      -- ui
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if LazyVim.has("trouble.nvim") then
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      if LazyVim.pick.want() ~= "snacks" then
        return
      end
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },
}
