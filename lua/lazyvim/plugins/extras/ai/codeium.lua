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
        accept_fallback = "<tab>",
        key_bindings = {
          accept = "<tab>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
    },
    config = function(_, opts)
      LazyVim.cmp.ai_accept = function()
        if require("codeium.virtual_text").get_current_completion_item() then
          LazyVim.create_undo()
          vim.api.nvim_input(require("codeium.virtual_text").accept())
          return true
        end
      end
      if opts.virtual_text.key_bindings.accept == "<tab>" then
        opts.virtual_text.key_bindings.accept = false
      end
      require("codeium").setup(opts)
    end,
  },

  -- codeium cmp source
  {
    "nvim-cmp",
    optional = true,
    dependencies = { "codeium.nvim" },
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
