local k = require("lazyvim.keymaps").get_keymaps()

return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { k.ts_decrement_selection, desc = "Decrement Selection", mode = "x" },
        { k.ts_increment_selection, desc = "Increment Selection", mode = { "x", "n" } },
      },
    },
  },

  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { k.ts_increment_selection, desc = "Increment Selection" },
      { k.ts_decrement_selection, desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = (k.ts_increment_selection and k.ts_increment_selection ~= "") and k.ts_increment_selection
            or false,
          node_incremental = (k.ts_increment_selection and k.ts_increment_selection ~= "") and k.ts_increment_selection
            or false,
          scope_incremental = false,
          node_decremental = (k.ts_decrement_selection and k.ts_decrement_selection ~= "") and k.ts_decrement_selection
            or false,
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            [k.ts_ns_function_outer] = "@function.outer",
            [k.ts_ns_class_outer] = "@class.outer",
            [k.ts_ns_parameter_inner] = "@parameter.inner",
          },
          goto_next_end = {
            [k.ts_ne_function_outer] = "@function.outer",
            [k.ts_ne_class_outer] = "@class.outer",
            [k.ts_ne_parameter_inner] = "@parameter.inner",
          },
          goto_previous_start = {
            [k.ts_ps_function_outer] = "@function.outer",
            [k.ts_ps_class_outer] = "@class.outer",
            [k.ts_ps_parameter_inner] = "@parameter.inner",
          },
          goto_previous_end = {
            [k.ts_pe_function_outer] = "@function.outer",
            [k.ts_pe_class_outer] = "@class.outer",
            [k.ts_pe_parameter_inner] = "@parameter.inner",
          },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    config = function()
      -- If treesitter is already loaded, we need to run config again for textobjects
      if LazyVim.is_loaded("nvim-treesitter") then
        local opts = LazyVim.opts("nvim-treesitter")
        require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
      end

      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
      local configs = require("nvim-treesitter.configs")
      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    opts = {},
  },
}
