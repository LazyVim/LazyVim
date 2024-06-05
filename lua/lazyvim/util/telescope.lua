---@class lazyvim.util.telescope.opts
---@field cwd? string|boolean
---@field show_untracked? boolean

---@class lazyvim.util.telescope
---@overload fun(builtin:string, opts?:lazyvim.util.telescope.opts)
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
---@param builtin string
---@param opts? lazyvim.util.telescope.opts
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = LazyVim.root() }, opts or {}) --[[@as lazyvim.util.telescope.opts]]
    if builtin == "files" then
      if
        vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.git")
        and not vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.ignore")
        and not vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.rgignore")
      then
        if opts.show_untracked == nil then
          opts.show_untracked = true
        end
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.uv.cwd() then
      local function open_cwd_dir()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        M.telescope(
          params.builtin,
          vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
        )()
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
end

function M.config_files()
  return LazyVim.telescope("find_files", { cwd = vim.fn.stdpath("config") })
end

return M
