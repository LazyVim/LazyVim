return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    branch = "main",
    build = ":TSUpdate",
    lazy = true,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    init = function() end,
    ---@param opts TSConfig
    config = function(_, opts)
      if vim.fn.executable("tree-sitter") == 0 then
        LazyVim.error("**treesitter-main** requires the `tree-sitter` executable to be installed")
        return
      end
      if type(opts.ensure_installed) ~= "table" then
        error("opts.ensure_installed must be a table")
      end

      local TS = require("nvim-treesitter")
      TS.setup(opts)

      local needed = LazyVim.dedup(opts.ensure_installed --[[@as string[] ]])
      local installed = TS.get_installed("parsers")
      local install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, needed)

      if #install > 0 then
        TS.install(install, { summary = true })
        vim.list_extend(installed, install)
      end

      -- backwards compatibility with the old treesitter config for indent
      if vim.tbl_get(opts, "indent", "enable") then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      -- backwards compatibility with the old treesitter config for highlight
      if vim.tbl_get(opts, "highlight", "enable") then
        vim.api.nvim_create_autocmd("FileType", {
          callback = function(ev)
            local lang = vim.treesitter.language.get_lang(ev.match)
            if vim.tbl_contains(installed, lang) then
              pcall(vim.treesitter.start)
            end
          end,
        })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {},
    keys = function()
      local moves = {
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      }
      local ret = {} ---@type LazyKeysSpec[]
      for method, keymaps in pairs(moves) do
        for key, query in pairs(keymaps) do
          local desc = query:gsub("@", ""):gsub("%..*", "")
          desc = desc:sub(1, 1):upper() .. desc:sub(2)
          desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
          desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
          ret[#ret + 1] = {
            key,
            function()
              require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
            end,
            desc = desc,
            mode = { "n", "x", "o" },
            silent = true,
          }
        end
      end
      return ret
    end,
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)
    end,
  },
}
