return {
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {},
    keys = function()
      local ret = {}
      local directions = { "left", "down", "up", "right" }
      local keys = { "h", "j", "k", "l" }
      local move = require("mini.move")
      for i, dir in ipairs(directions) do
        ret[#ret + 1] = {
          "<A-" .. keys[i] .. ">",
          mode = { "i", "n" },
          function()
            move.move_line(dir)
          end,
        }
      end
      for i, dir in ipairs(directions) do
        ret[#ret + 1] = {
          "<A-" .. keys[i] .. ">",
          mode = { "v" },
          function()
            move.move_selection(dir)
          end,
        }
      end
      return ret
    end,
  },
}
