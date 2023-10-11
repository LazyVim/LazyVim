-- TODO: add TabNine icon if is available
local tabnine_icon = ""

return {
  -- Tabnine cmp source
  {
    "nvim-cmp",
    dependencies = {
      -- Add TabNine support, make sure you run :CmpTabnineHub after installation.
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
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

      -- Format the completion menu, remove the percentage and add icons
      opts.formatting.format = function(entry, vim_item)
        local icons = require("lazyvim.config").icons.kinds
        if icons[vim_item.kind] then
          vim_item.kind = icons[vim_item.kind] .. vim_item.kind
        end

        -- Add tabnine icon and hide percentage in the menu
        if entry.source.name == "cmp_tabnine" then
          vim_item.kind = tabnine_icon .. " TabNine"
          vim_item.menu = ""

          if (entry.completion_item.data or {}).multiline then
            vim_item.kind = vim_item.kind .. " " .. "[ML]"
          end
        end

        return vim_item
      end
    end,
  },
  -- Show TabNine status in lualine
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local started = false
      local function status()
        if not package.loaded["cmp"] then
          return
        end
        for _, s in ipairs(require("cmp").core.sources) do
          if s.name == "cmp_tabnine" then
            if s.source:is_available() then
              started = true
            else
              return started and "error" or nil
            end
            if s.status == s.SourceStatus.FETCHING then
              return "pending"
            end
            return "ok"
          end
        end
      end

      local Util = require("lazyvim.util")
      local colors = {
        ok = Util.fg("Special"),
        error = Util.fg("DiagnosticError"),
        pending = Util.fg("DiagnosticWarn"),
      }
      table.insert(opts.sections.lualine_x, 3, {
        function()
          return tabnine_icon
        end,
        cond = function()
          return status() ~= nil
        end,
        color = function()
          return colors[status()] or colors.ok
        end,
      })
    end,
  },
}
