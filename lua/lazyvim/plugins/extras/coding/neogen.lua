return {
  -- create annotation for code
  "danymat/neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter" },

  opts = function()
    return {
      enabled = true,
      snippet_engine = "luasnip",
    }
  end,

  keys = {
    "<Leader>cc",
    function()
      require("neogen").generate({})
    end,
    desc = "Neogen code annotation",
  },
}
