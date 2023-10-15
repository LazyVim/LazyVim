local Util = require("lazyvim.util")

local function tabnine_build_cmd()
  if vim.loop.os_uname().sysname == "Windows_NT" then
    return "pwsh -noni .\\install.ps1"
  else
    return "./install.sh"
  end
end

return {
  -- Tabnine cmp source
  {
    "nvim-cmp",
    dependencies = {
      -- Add TabNine support, make sure you run :CmpTabnineHub after installation.
      {
        "tzachar/cmp-tabnine",
        build = tabnine_build_cmd(),
        dependencies = "hrsh7th/nvim-cmp",
        opts = {
          max_lines = 1000,
          max_num_results = 3,
          sort = true,
        },
        config = function(_, opts)
          local tabnine = require("cmp_tabnine.config")
          tabnine:setup(opts)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "cmp_tabnine",
        group_index = 1,
        priority = 100,
      })

      opts.formatting.format = Util.inject.args(opts.formatting.format, function(entry, item)
        -- Hide percentage in the menu
        if entry.source.name == "cmp_tabnine" then
          item.menu = ""
        end
      end)
    end,
  },
  -- Show TabNine status in lualine
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local icon = require("lazyvim.config").icons.kinds.TabNine
      table.insert(opts.sections.lualine_x, 2, require("lazyvim.util").lualine.cmp_source("cmp_tabnine", icon))
    end,
  },
}
