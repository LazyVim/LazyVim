return {
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>uGdd",
        function()
          require("duck").hatch()
        end,
        desc = "Hatch a duck",
      },
      {
        "<leader>uGdD",
        function()
          require("duck").hatch()
          require("duck").hatch()
          require("duck").hatch()
          require("duck").hatch()
          require("duck").hatch("🦆", 10)
        end,
        desc = "Hatch ducks",
      },
      {
        "<leader>uGdc",
        function()
          require("duck").hatch("🐈")
        end,
        desc = "Catch a cat",
      },
      {
        "<leader>uGdC",
        function()
          require("duck").hatch("🐈")
          require("duck").hatch("🐈")
          require("duck").hatch("🐈")
          require("duck").hatch("🐈")
          require("duck").hatch("🐈", 0.75)
        end,
        desc = "Catch more cats",
      },
      {
        "<leader>uGdr",
        function()
          require("duck").hatch("🦀")
        end,
        desc = "Get some rust",
      },
      {
        "<leader>uGdR",
        function()
          require("duck").hatch("🦀")
          require("duck").hatch("🦀")
          require("duck").hatch("🦀")
          require("duck").hatch("🦀")
          require("duck").hatch("🦀", 12)
        end,
        desc = "Unleash Rustaceans",
      },
      {
        "<leader>uGdk",
        function()
          require("duck").cook()
        end,
        desc = "Cook a duck",
      },
      {
        "<leader>uGda",
        function()
          require("duck").cook_all()
        end,
        desc = "Cook ’em all",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local wk = require("which-key")
      wk.add({
        { "<leader>uGd", group = "Duck" },
      })
    end,
  },
}
