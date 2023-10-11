local Config = require("lazyvim.config")

---@param extra string
return vim.tbl_map(function(extra)
  return { import = "lazyvim.plugins.extras." .. extra }
end, Config.json.data.extras)
