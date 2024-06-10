---@class lazyvim.util.telescope
---@overload fun(builtin:string, opts?:lazyvim.util.pick.Opts)
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
---@param builtin string
---@param opts? lazyvim.util.pick.Opts
function M.open(builtin, opts)
  opts = opts or {}
  if opts.cwd and opts.cwd ~= vim.uv.cwd() then
    local function open_cwd_dir()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick.open(
        builtin,
        vim.tbl_deep_extend("force", {}, opts or {}, {
          root = false,
          default_text = line,
        })
      )
    end
    ---@diagnostic disable-next-line: inject-field
    opts.attach_mappings = function(_, map)
      -- opts.desc is overridden by telescope, until it's changed there is this fix
      map("i", "<a-c>", open_cwd_dir, { desc = "Open cwd Directory" })
      return true
    end
  end

  require("telescope.builtin")[builtin](opts)
end

M.telescope = function(...)
  LazyVim.deprecate("LazyVim.telescope", "LazyVim.pick")
  return LazyVim.pick.wrap(...)
end

function M.config_files()
  return LazyVim.pick.config_files()
end

return M
