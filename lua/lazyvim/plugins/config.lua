local function load(name)
  local Util = require("lazy.core.util")
  -- always load lazyvim, then user file
  for _, mod in ipairs({ "lazyvim.config." .. name, "config." .. name }) do
    Util.try(function()
      require(mod)
    end, {
      msg = "Failed loading " .. mod,
      on_error = function(msg)
        local modpath = require("lazy.core.cache").find(mod)
        if modpath then
          Util.error(msg)
        end
      end,
    })
  end
end

-- load options here, before lazy init while sourcing plugin modules
-- this is needed to make sure options will be correctly applied
-- after installing missing plugins
load("options")

-- autocmds and keymaps can wait to load
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    load("autocmds")
    load("keymaps")
  end,
})

return {}
