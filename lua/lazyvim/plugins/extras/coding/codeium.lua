return {

  -- codeium cmp source
  {
    "nvim-cmp",
    dependencies = {
      {
        "jcdickinson/codeium.nvim",
        opts = {},
        config = function(_, opts)
          require("codeium").setup(opts)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "codeium", group_index = 2 })
      opts.sorting = opts.sorting or require("cmp.config.default")().sorting
    end,
  },

}
