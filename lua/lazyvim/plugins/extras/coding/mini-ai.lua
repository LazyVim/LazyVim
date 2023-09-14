local load_textobjects = false

---@param ts_opts PluginOpts
local function source_runtime_textobjects(ts_opts)
  -- PERF: no need to load the plugin, if we only need its queries for mini.ai

  if ts_opts.textobjects then -- the user defined textobjects
    for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
      if ts_opts.textobjects[mod] and ts_opts.textobjects[mod].enable then
        local Loader = require("lazy.core.loader")
        Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
        local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
        require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
        break
      end
    end
  end
end

---@param treesitter_plugin LazyPlugin
local function decorate_config_function(treesitter_plugin)
  -- the config function is defined in lazyvim.plugins.treesitter
  local config_to_decorate = treesitter_plugin.config

  treesitter_plugin.config = function(_, opts)
    if config_to_decorate then
      config_to_decorate(treesitter_plugin, opts)
    end
    if load_textobjects then
      source_runtime_textobjects(opts)
    end
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function(plugin)
      decorate_config_function(plugin) -- avoiding code duplication
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- disable rtp plugin, as we only need its queries for mini.ai
          -- In case other textobject modules are enabled, we will load them
          -- once nvim-treesitter is loaded
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          load_textobjects = true
        end,
      },
    },
    opts = function(_, opts)
      -- override the default textobjects defined in lazyvim.plugins.treesitter.
      -- when using this extra, the user is expected to add textobjects
      -- on a need-to-have basis
      opts.textobjects = nil
    end,
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    enabled = true, -- overrides the function defined in lazyvim.plugins.coding
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {

          -- opt-out: using neovim's text object selection for tags:
          t = false,
          -- opt-in: use the following override in the "opts" function of your spec:
          -- opts.custom_textobjects.t = nil -- opt-in to mini.ai's tag textobject

          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      require("lazyvim.util").on_load("which-key.nvim", function()
        ---@type table<string, string|table>
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs({ n = "Next", l = "Last" }) do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end
        require("which-key").register({
          mode = { "o", "x" },
          i = i,
          a = a,
        })
      end)
    end,
  },
}
