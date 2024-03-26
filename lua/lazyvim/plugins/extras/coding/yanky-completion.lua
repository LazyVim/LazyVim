return {
  -- add yanky as completion source
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "chrisgrieser/cmp_yanky" },
    opts = function(_, opts)
      opts.sources = require("cmp").config.sources(vim.list_extend(opts.sources, {
        { name = "cmp_yanky" },
      }))
    end,
  },
}
