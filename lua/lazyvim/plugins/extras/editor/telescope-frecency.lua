---@class lazyvim.extras.editor.telescope_frecency_integration
---@field config table
---@field defaults table
local FrecencyIntegration = {}
FrecencyIntegration.__index = FrecencyIntegration
FrecencyIntegration.config = { _values = false }

---@class lazyvim.extras.editor.telescope_frecency_integration_config
---@field lhs_switch_to string: key to switch from frecency to oldfiles and vice versa
---@field pickers lazyvim.extras.editor.telescope_frecency_integration_pickers_config
FrecencyIntegration.defaults = {
  lhs_switch_to = "[",

  ---@class lazyvim.extras.editor.telescope_frecency_integration_pickers_config
  ---@field oldfiles table: telescope oldfiles picker options
  ---@field frecency table: telescope frecency picker options
  pickers = {
    oldfiles = {
      hidden = false,
      previewer = false,
      layout_config = { width = 0.9, height = 0.4 },
      theme = require("telescope.themes").get_ivy,
    },
    frecency = {
      hidden = false,
      previewer = false,
      layout_config = { width = 0.9, height = 0.4 },
      theme = require("telescope.themes").get_ivy,
      workspace = "*",
    },
  },
}
setmetatable(FrecencyIntegration.config, {
  __index = function(t, k)
    if t._values then
      t.config = vim.deepcopy(t._values)
      return t.config[k]
    else
      return FrecencyIntegration.defaults[k]
    end
  end,
})

function FrecencyIntegration.setup(config)
  if type(config) ~= "table" then
    return
  end
  FrecencyIntegration.config._values = vim.tbl_deep_extend("force", FrecencyIntegration.defaults, config)
end

local function prompt_title(picker, o)
  if picker == "oldfiles" then
    return string.format("oldfiles: [%s]", o.cwd or "*")
  elseif picker == "frecency" then
    return string.format("frecency: [%s]", o.workspace)
  end
end

local function set_default_text_from_picker(picker, opts)
  local prompt_text = picker:_get_prompt()
  opts.default_text = prompt_text
  return opts
end

local Picker = {}
Picker.oldfiles = {}

local actions = {}

---@diagnostic disable:need-check-nil
local function picker_config(picker, opts)
  opts = vim.tbl_deep_extend("force", FrecencyIntegration.config.pickers[picker], opts)

  if not opts.prompt_title then
    opts.prompt_title = prompt_title(picker, opts)
  end

  if opts.theme then
    opts = opts.theme(opts)
  end

  return opts
end

actions.frecency = function(prompt_bufnr, opts, opts_oldfiles)
  local actions_state = require("telescope.actions.state")

  return function(bufnr)
    bufnr = bufnr or prompt_bufnr

    local current_picker = actions_state.get_current_picker(bufnr)
    opts = set_default_text_from_picker(current_picker, opts)
    require("telescope.actions").close(bufnr)

    opts.attach_mappings = function(_, map)
      map({ "i", "n" }, FrecencyIntegration.config.lhs_switch_to, actions.oldfiles(prompt_bufnr, opts_oldfiles, opts))
      return true
    end
    require("telescope").extensions.frecency.frecency(opts)
  end
end

function Picker.oldfiles(opts, opts_frecency)
  local params = {
    opts = picker_config("oldfiles", opts or {}),
    opts_frecency = picker_config("frecency", opts_frecency or {}),
  }
  return function()
    params.opts.attach_mappings = function(prompt_bufnr, map)
      map(
        { "i", "n" },
        FrecencyIntegration.config.lhs_switch_to,
        actions.frecency(prompt_bufnr, params.opts_frecency, params.opts)
      )
      return true
    end
    require("telescope.builtin").oldfiles(params.opts)
  end
end

actions.oldfiles = function(prompt_bufnr, opts, opts_frecency)
  local actions_state = require("telescope.actions.state")

  return function(bufnr)
    bufnr = bufnr or prompt_bufnr

    local current_picker = actions_state.get_current_picker(bufnr)
    opts = set_default_text_from_picker(current_picker, opts)
    require("telescope.actions").close(bufnr)

    opts.attach_mappings = function(_, map)
      map({ "i", "n" }, FrecencyIntegration.config.lhs_switch_to, actions.frecency(prompt_bufnr, opts_frecency, opts))
      return true
    end
    require("telescope.builtin").oldfiles(opts)
  end
end

function Picker.frecency(opts, opts_oldfiles)
  local params = {
    opts = picker_config("frecency", opts or {}),
    opts_oldfiles = picker_config("oldfiles", opts_oldfiles or {}),
  }
  return function()
    params.opts.attach_mappings = function(prompt_bufnr, map)
      map(
        { "i", "n" },
        FrecencyIntegration.config.lhs_switch_to,
        actions.oldfiles(prompt_bufnr, params.opts_oldfiles, params.opts)
      )
      return true
    end

    require("telescope").extensions.frecency.frecency(params.opts)
  end
end

local function apply_keymaps(opts, trigger_keys)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}

  -- 1. build keymaps
  for _, key in ipairs(trigger_keys) do
    if opts.integration.frecency.keymaps[key[1]] then
      local conf = opts.integration.frecency.keymaps[key[1]]
      local pk = Picker[conf[1]]
      if pk then
        table.insert(keymaps, { key[1], pk(conf[2], conf[3]) })
      end
    end
  end

  -- 2. apply keymaps
  keymaps = Keys.resolve(keymaps)

  ---@diagnostic disable:inject-field
  for _, keys in pairs(keymaps) do
    local _opts = Keys.opts(keys)
    _opts.has = nil
    _opts.silent = opts.silent ~= false
    vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, _opts)
  end
end

local telescope_trigger_keys = {
  { ";<Leader>", desc = "Recent (frecency cwd)" },
  { "<Leader>;", desc = "Recent (frecency)" },
}
return {

  desc = "A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history.",
  {
    "nvim-telescope/telescope.nvim",

    keys = telescope_trigger_keys,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-frecency.nvim",
        opts = function(_, opts)
          return vim.tbl_deep_extend("keep", opts, {
            integration = {
              frecency = {
                -- stylua: ignore
                keymaps = {
                  [ ";<Leader>" ] = {"frecency", {workspace = "CWD", prompt_title = "frecency: CWD"}, {cwd = vim.loop.cwd()}},
                  [ "<Leader>;" ] = {"frecency", {}, {}},
                },
                enable_oldfiles_mappings = false,
              },
              extensions = {
                frecency = {
                  show_scores = true,
                  show_filter_column = { "CWD" },
                },
              },
            },
          })
        end,

        config = function(_, opts)
          if
            type(opts) == "table"
            and type(opts.integration) == "table"
            and type(opts.integration.frecency) == "table"
          then
            if opts.integration.frecency.enable_oldfiles_mappings then
              opts.integration.frecency.keymaps["<Leader>fr"] = { "oldfiles", {}, {} }
              opts.integration.frecency.keymaps["<Leader>fR"] = { "oldfiles", { cwd = vim.loop.cwd() }, {} }

              telescope_trigger_keys[#telescope_trigger_keys + 1] = { "<Leader>fr", desc = "Recent" }
              telescope_trigger_keys[#telescope_trigger_keys + 1] = { "<Leader>fR", desc = "Recent (cwd)" }
            end

            FrecencyIntegration.setup(opts.integration.frecency)
          end

          require("telescope").setup(opts)
          require("telescope").load_extension("frecency")
          apply_keymaps(opts, telescope_trigger_keys)

          -- load telescope with new keys (telescope_trigger_keys)
          require("lazy.core.loader").load("telescope.nvim", { "telescope-frecency" })
        end,
      },
    },
  },
}
