---@class lazyvim.util.copy_path
local M = {}

--- Get the current buffer's file path. Returns nil if not a file buffer.
---@return string|nil
function M.bufpath()
  local name = vim.api.nvim_buf_get_name(0)
  return name ~= "" and LazyVim.norm(name) or nil
end

--- Absolute file path of the current buffer, normalized.
--- Returns nil if not a file buffer.
---@return string|nil
function M.absolute()
  local p = M.bufpath()
  if not p then
    return nil
  end
  -- Expand to absolute (handles ~, .git worktrees, etc.) and normalize
  return LazyVim.norm(vim.fn.expand(p)) or p
end

--- Parent directory of the current buffer's file.
--- Returns nil if not a file buffer.
---@return string|nil
function M.directory()
  local p = M.absolute()
  if not p then
    return nil
  end
  return vim.fs.dirname(p) .. "/"
end

--- File path relative to project root.
--- Returns the filename alone if at the project root.
--- Returns nil if not a file buffer.
---@return string|nil
function M.relative()
  local abs = M.absolute()
  if not abs then
    return nil
  end
  -- LazyVim.root() can fail in headless/unusual contexts; fall back to absolute
  local ok, root = pcall(LazyVim.root)
  if not ok then
    return abs
  end
  -- Ensure root ends with / for consistent string matching
  if root:sub(-1) ~= "/" then
    root = root .. "/"
  end
  if abs:find(root, 1, true) == 1 then
    return abs:sub(#root + 1)
  end
  -- Not under project root — fall back to absolute
  return abs
end

--- Filename of current buffer (with extension).
--- Returns nil if not a file buffer.
---@return string|nil
function M.filename()
  local p = M.bufpath()
  if not p then
    return nil
  end
  return vim.fs.basename(p)
end

--- Filename of current buffer (without extension).
--- Returns nil if not a file buffer.
---@return string|nil
function M.filename_no_ext()
  local name = M.filename()
  if not name then
    return nil
  end
  -- Remove extension (everything after the last dot)
  local base, ext = name:match("^(.*)%.([^.]*)$")
  if base and ext then
    return base
  end
  return name -- no extension to strip
end

--- Current line number (1-based).
---@return integer
function M.line_number()
  local pos = vim.api.nvim_win_get_cursor(0)
  return pos[1]
end

--- Current column number (1-based, character offset from start of line).
---@return integer
function M.column_number()
  local pos = vim.api.nvim_win_get_cursor(0)
  -- nvim_win_get_cursor returns 0-based column; convert to 1-based
  return pos[2] + 1
end

--- Git root directory, or project root as fallback.
---@return string
function M.project_root()
  -- LazyVim.root.git() can fail in headless/unusual contexts; fall back to cwd
  local ok, root = pcall(LazyVim.root.git)
  if not ok then
    return vim.uv.cwd() .. "/"
  end
  return root .. "/"
end

--- Append ":line" to the given path.
---@param path string
---@return string
function M.with_line(path)
  return path .. ":" .. M.line_number()
end

--- Append ":line:column" to the given path.
---@param path string
---@return string
function M.with_column(path)
  return path .. ":" .. M.column_number()
end

--- Copy text to system clipboard and print it via notification.
--- If the buffer has no associated file, shows a warning instead.
---@param get_path fun(): string|nil  Function that returns the path string or nil
---@param desc string  Description for the notification title and which-key
function M.copy(get_path, desc)
  local text = get_path()
  if not text then
    LazyVim.warn("Current buffer is not attached to a file!", { title = "Copy Path" })
    return
  end
  -- Write to system clipboard (+ register), character mode for clean copy
  vim.fn.setreg("+", text, "c")
  -- Print the copied value for user feedback
  LazyVim.info("Copied: " .. text, { title = desc })
end

-- ─── Convenience functions that wire up specific path representations ───

--- Copy relative-to-project file path + line + column.
M.copy_relative_with_line_column = function()
  M.copy(function()
    return M.with_column(M.with_line(M.relative()))
  end, "Copy Path (relative + line:col)")
end

--- Copy relative-to-project file path + line number.
M.copy_relative_with_line = function()
  M.copy(function()
    return M.with_line(M.relative())
  end, "Copy Path (relative + line)")
end

--- Copy relative-to-project file path only.
M.copy_relative = function()
  M.copy(function()
    return M.relative()
  end, "Copy Path (relative)")
end

--- Copy relative-to-project directory.
M.copy_relative_directory = function()
  M.copy(function()
    local rel = M.relative()
    if not rel then
      return nil
    end
    return vim.fs.dirname(rel) .. "/"
  end, "Copy Directory (relative)")
end

--- Copy absolute file path + line + column.
M.copy_absolute_with_line_column = function()
  M.copy(function()
    return M.with_column(M.with_line(M.absolute()))
  end, "Copy Path (absolute + line:col)")
end

--- Copy absolute file path + line number.
M.copy_absolute_with_line = function()
  M.copy(function()
    return M.with_line(M.absolute())
  end, "Copy Path (absolute + line)")
end

--- Copy absolute file path only.
M.copy_absolute = function()
  M.copy(function()
    return M.absolute()
  end, "Copy Path (absolute)")
end

--- Copy absolute directory.
M.copy_absolute_directory = function()
  M.copy(function()
    return M.directory()
  end, "Copy Directory (absolute)")
end

--- Copy project (git root) directory.
M.copy_project = function()
  M.copy(function()
    return M.project_root()
  end, "Copy Project Root")
end

--- Copy filename with extension.
M.copy_filename = function()
  M.copy(function()
    return M.filename()
  end, "Copy Filename")
end

--- Copy filename without extension.
M.copy_filename_no_ext = function()
  M.copy(function()
    return M.filename_no_ext()
  end, "Copy Filename (no ext)")
end

return M
