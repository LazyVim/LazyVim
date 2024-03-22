local goto_template_file = function()
  local params = vim.lsp.util.make_position_params(0)
  vim.lsp.buf_request(0, "angular/getTemplateLocationForComponent", params, function(_, result)
    if result then
      vim.lsp.util.jump_to_location(result, "utf-8")
    end
  end)
end

local goto_component_file = function()
  local params = vim.lsp.util.make_position_params(0)
  vim.lsp.buf_request(0, "angular/getComponentsWithTemplateFile", params, function(_, result)
    if result then
      if #result == 1 then
        vim.lsp.util.jump_to_location(result[1], "utf-8")
      else
        vim.fn.setqflist({}, " ", {
          title = "Angular Language Server",
          items = vim.lsp.util.locations_to_items(result, "utf-8"),
        })
        vim.cmd.copen()
      end
    end
  end)
end

---@param id string
---@param cmd string | function
---@param desc string
local create_cmd = function(id, cmd, desc)
  vim.api.nvim_create_user_command(string.format("Ng%s", id), cmd, {
    desc = string.format("Angular » %s", desc),
  })
end

return {
  {
    "nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular" })
      end
    end,
  },

  {
    "nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          root_dir = function(fname)
            local util = require("lspconfig").util
            local original = util.root_pattern("angular.json", "project.json")(fname)
            -- set fallback for nx workspace support
            local nx_fallback = util.root_pattern("nx.json", "workspace.json")(fname)
            local git_fallback = util.root_pattern(".git")(fname)
            return original or nx_fallback or git_fallback
          end,
        },
      },
      setup = {
        angularls = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "angularls" then
              -- disable lsp rename to not conflicting with tsserver
              client.server_capabilities.renameProvider = false
              -- run :Ngc to go to the component of the current template buffer
              create_cmd("c", goto_component_file, "Go to component file")
              -- run :Ngt to go to the template of the current component
              create_cmd("t", goto_template_file, "Go to template file")
            end
          end)
          return false
        end,
      },
    },
  },
}
