local M = {}

---@param opts? LazyVimSettings
function M.setup(opts)
  if not package.loaded.lazy then
    require("lazyvim.config.lazy")
  end
  local settings = require("lazyvim.config.settings")
  package.loaded["lazyvim.config.settings"] = vim.tbl_deep_extend("force", settings, opts or {})
  require("lazyvim.config.options")
  require("lazyvim.config.autocmds")
  require("lazyvim.config.keymaps")
end

return M
