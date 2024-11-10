return {

  -- codeium
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = vim.g.ai_cmp,
      virtual_text = {
        enabled = not vim.g.ai_cmp,
        accept_fallback = vim.g.ai_suggest_accept,
        key_bindings = {
          accept = vim.g.ai_suggest_accept,
          accept_word = vim.g.ai_suggest_accept_word,
          accept_line = vim.g.ai_suggest_accept_line,
          next = vim.g.ai_suggest_next,
          prev = vim.g.ai_suggest_prev,
          clear = vim.g.ai_suggest_clear,
        },
      },
    },
  },
  -- codeium cmp source
  {
    "nvim-cmp",
    optional = true,
    dependencies = { "codeium.nvim" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source("codeium"))
    end,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        compat = vim.g.ai_cmp and { "codeium" } or nil,
      },
    },
    dependencies = {
      "codeium.nvim",
      vim.g.ai_cmp and { "saghen/blink.compat" } or {},
    },
  },
}
