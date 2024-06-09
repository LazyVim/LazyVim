---@class FzfLuaOpts: lazyvim.util.pick.Opts
---@field cmd string?

LazyVim.pick.commands = {
  files = "files",
}

---@param command string
---@param opts? FzfLuaOpts
LazyVim.pick._open = function(command, opts)
  opts = opts or {}

  if opts.cmd == nil and command == "git_files" and opts.show_untracked then
    opts.cmd = "git ls-files --exclude-standard --cached --others"
  end
  return require("fzf-lua")[command](opts)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    keys = function()
      return {}
    end,
  },
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    opts = {
      [1] = "default-title",
      fzf_colors = {
        ["fg"] = { "fg", "FzfLuaNormal" },
        ["bg"] = { "bg", "FzfLuaNormal" },
        ["hl"] = { "fg", "Special" },
        ["fg+"] = { "fg", "Visual" },
        ["bg+"] = { "bg", "Visual" },
        ["hl+"] = { "fg", "Special" },
        ["info"] = { "fg", "NonText" },
        ["border"] = { "fg", "FzfLuaBorder" },
        ["gutter"] = { "bg", "FzfLuaNormal" },
        ["query"] = { "fg", "FzfLuaNormal" },
        ["prompt"] = { "fg", "FzfLuaNormal" },
        ["pointer"] = { "fg", "FzfLuaMarker" },
        ["marker"] = { "fg", "FzfLuaMarker" },
        ["header"] = { "fg", "FzfLuaNormal" },
      },
    },
    config = function(_, opts)
      local config = require("fzf-lua.config")
      local actions = require("trouble.sources.fzf").actions
      config.defaults.actions.files["ctrl-t"] = actions.open_all
      config.defaults.actions.files["alt-t"] = actions.open
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      -- vim.env.FZF_DEFAULT_OPTS = ""
      require("fzf-lua").setup(opts)
    end,
    keys = {
      { "<esc>", "<cmd>close<cr>", ft = "fzf", mode = "t", nowait = true },
      { "<c-j>", "<Down>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<Up>", ft = "fzf", mode = "t", nowait = true },
      {
        "<leader>,",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><space>", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
      -- find
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
      { "<leader>ff", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
      { "<leader>fF", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", LazyVim.pick("oldfiles", { root = false }), desc = "Recent (cwd)" },
      -- git
      { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      -- search
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
      { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
      { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
      {
        "<leader>ss",
        function()
          require("fzf-lua").lsp_document_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("fzf-lua").lsp_dynamic_workspace_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(Keys, {
        {
          "gd",
          "<cmd>FzfLua lsp_definitions     jump_to_single_result=true<cr>",
          desc = "Goto Definition",
          has = "definition",
        },
        { "gr", "<cmd>FzfLua lsp_references      jump_to_single_result=true<cr>", desc = "References", nowait = true },
        { "gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true<cr>", desc = "Goto Implementation" },
        { "gy", "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true<cr>", desc = "Goto T[y]pe Definition" },
      })
    end,
  },
}
