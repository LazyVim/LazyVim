-- animations
return {
  "echasnovski/mini.animate",
  recommended = true,
  event = "VeryLazy",
  opts = function()
    -- don't use animate when scrolling with the mouse
    local mouse_scrolled = false
    for _, scroll in ipairs({ "Up", "Down" }) do
      local key = "<ScrollWheel" .. scroll .. ">"
      vim.keymap.set({ "", "i" }, key, function()
        mouse_scrolled = true
        return key
      end, { expr = true })
    end

    local animate = require("mini.animate")
    return {
      resize = {
        timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        -- diable animate when resize acitve
        -- best effort to avoid lagging when doing a lot of relative resizing
        subresize = animate.gen_subresize.equal({
          predicate = function()
            return not animate.is_active("resize")
          end,
        }),
      },
      scroll = {
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
        subscroll = animate.gen_subscroll.equal({
          predicate = function(total_scroll)
            if mouse_scrolled then
              mouse_scrolled = false
              return false
            end
            return total_scroll > 1
          end,
        }),
      },
    }
  end,
  -- because of "VeryLazy" event, "MiniAnimate" module has already been exported
  -- make LazyVim key maps smoother
  keys = {
    {
      "<C-Up>",
      function()
        MiniAnimate.execute_after("resize", "resize +2")
      end,
      desc = "Increase Window Height",
    },
    {
      "<C-Down>",
      function()
        MiniAnimate.execute_after("resize", "resize -2")
      end,
      desc = "Decrease Window Height",
    },
    {
      "<C-Left>",
      function()
        MiniAnimate.execute_after("resize", "vertical resize -2")
      end,
      desc = "Decrease Window Width",
    },
    {
      "<C-Right>",
      function()
        MiniAnimate.execute_after("resize", "vertical resize +2")
      end,
      desc = "Increase Window Width",
    },
  },
}
