return {
  {
    "nvim-cmp",
    dependencies = {
      -- Add TabNine source, make sure you run :CmpTabnineHub after installation.
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        dependencies = "hrsh7th/nvim-cmp",
        -- Only limit top 3 sources, refer https://github.com/tzachar/cmp-tabnine?tab=readme-ov-file#setup
        opts = { max_lines = 1000, max_num_results = 3, sort = true },
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "cmp_tabnine",
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
          -- TODO: return TabNine icon if TabNine is available
          return ""
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
