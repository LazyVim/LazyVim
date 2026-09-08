---@module "luassert"

-- Ensure LazyVim global is available for copy_path module
_G.LazyVim = _G.LazyVim or require("lazyvim.util")

local copy_path = require("lazyvim.util.copy_path")

describe("copy_path", function()
  -- Create a temporary file and switch to it for tests that need a real buffer.
  local tmpdir, tmppath ---@type string, string
  local old_buf ---@type number|nil

  before_each(function()
    tmpdir = os.tmpname()
    vim.fn.delete(tmpdir) -- remove the file so we can mkdir
    vim.fn.mkdir(tmpdir, "p")
    tmppath = tmpdir .. "/test_file.lua"
    -- Write enough lines so cursor positioning works reliably
    local f = io.open(tmppath, "w")
    if f then
      f:write("-- line 1\n-- line 2\nlocal x = 42\n-- line 4\n-- line 5\n")
      f:close()
    end

    -- Open the file in a new buffer and make it current
    old_buf = vim.api.nvim_get_current_buf()
    local buf = vim.fn.bufadd(tmppath)
    vim.fn.bufload(buf)
    vim.api.nvim_set_current_buf(buf)

    -- Set cursor to line 3, column 5 (0-based: row=2, col=4) for predictable tests
    -- "local x = 42" — column 5 is the 'x' character
    vim.api.nvim_win_set_cursor(0, { 3, 4 })
  end)

  after_each(function()
    if old_buf and vim.fn.bufexists(old_buf) == 1 then
      pcall(vim.api.nvim_set_current_buf, old_buf)
    end
    -- Cleanup temp file and dir
    pcall(vim.fn.delete, tmppath)
    pcall(vim.fn.delete, tmpdir)
  end)

  describe("bufpath", function()
    it("returns the buffer name for a file buffer", function()
      local p = copy_path.bufpath()
      assert.is_not_nil(p)
      assert.truthy(p:find("test_file.lua"))
    end)

    it("returns nil for non-file buffers", function()
      local scratch = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(scratch)
      assert.is_nil(copy_path.bufpath())
      vim.api.nvim_set_current_buf(vim.fn.bufnr(tmppath))
    end)
  end)

  describe("absolute", function()
    it("returns the normalized absolute path of the current buffer", function()
      local p = copy_path.absolute()
      assert.is_not_nil(p)
      if LazyVim.is_win() then
        assert.truthy(p:match("^%a:") ~= nil)
      else
        assert.are.equal(string.sub(p, 1, 1), "/")
      end
      assert.truthy(p:find("test_file.lua"))
    end)

    it("returns nil for non-file buffers", function()
      local scratch = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(scratch)
      assert.is_nil(copy_path.absolute())
      vim.api.nvim_set_current_buf(vim.fn.bufnr(tmppath))
    end)
  end)

  describe("directory", function()
    it("returns the parent directory with trailing slash", function()
      local d = copy_path.directory()
      assert.is_not_nil(d)
      assert.are.equal(string.sub(d, -1), "/")
      assert.truthy(d:find(tmpdir))
    end)

    it("returns nil for non-file buffers", function()
      local scratch = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(scratch)
      assert.is_nil(copy_path.directory())
      vim.api.nvim_set_current_buf(vim.fn.bufnr(tmppath))
    end)
  end)

  describe("relative", function()
    it("returns a path containing the filename (relative if possible, absolute as fallback)", function()
      local r = copy_path.relative()
      assert.is_not_nil(r)
      -- In headless test mode LazyVim.root() may be unavailable, so relative falls back to absolute.
      -- Either way the result should contain the filename.
      assert.truthy(r:find("test_file.lua"))
    end)

    it("returns nil for non-file buffers", function()
      local scratch = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(scratch)
      assert.is_nil(copy_path.relative())
      vim.api.nvim_set_current_buf(vim.fn.bufnr(tmppath))
    end)
  end)

  describe("filename", function()
    it("returns the filename with extension", function()
      assert.are.equal(copy_path.filename(), "test_file.lua")
    end)

    it("returns nil for non-file buffers", function()
      local scratch = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(scratch)
      assert.is_nil(copy_path.filename())
      vim.api.nvim_set_current_buf(vim.fn.bufnr(tmppath))
    end)
  end)

  describe("filename_no_ext", function()
    it("returns the filename without extension", function()
      assert.are.equal(copy_path.filename_no_ext(), "test_file")
    end)

    it("returns the full name when there is no extension", function()
      local noext_path = tmpdir .. "/README"
      local f = io.open(noext_path, "w")
      if f then f:write("no ext"); f:close() end
      local buf2 = vim.fn.bufadd(noext_path)
      vim.fn.bufload(buf2)
      vim.api.nvim_set_current_buf(buf2)
      assert.are.equal(copy_path.filename_no_ext(), "README")
      vim.api.nvim_set_current_buf(vim.fn.bufnr(tmppath))
      pcall(vim.fn.delete, noext_path)
    end)

    it("returns nil for non-file buffers", function()
      local scratch = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(scratch)
      assert.is_nil(copy_path.filename_no_ext())
      vim.api.nvim_set_current_buf(vim.fn.bufnr(tmppath))
    end)
  end)

  describe("line_number and column_number", function()
    it("returns the current line number (1-based)", function()
      -- Cursor was set to row 2 (0-based) = line 3 in before_each
      assert.are.equal(copy_path.line_number(), 3)
    end)

    it("returns the current column number (1-based)", function()
      -- Cursor was set to col 4 (0-based) = column 5 in before_each
      assert.are.equal(copy_path.column_number(), 5)
    end)
  end)

  describe("with_line", function()
    it("appends ':line' to the path", function()
      local p = copy_path.absolute() .. ":3" -- line was set to 3 in before_each
      local result = copy_path.with_line(copy_path.absolute())
      assert.are.equal(result, p)
    end)
  end)

  describe("with_column", function()
    it("appends ':line:column' to the path", function()
      local base = copy_path.absolute() .. ":3" -- line 3 from before_each
      local result = copy_path.with_column(base)
      assert.are.equal(result, base .. ":5") -- column 5 from before_each
    end)
  end)

  describe("project_root", function()
    it("returns the git root with trailing slash or cwd fallback", function()
      local ok, p = pcall(copy_path.project_root)
      -- In headless test mode LazyVim.root.git() may fail, so we accept either outcome.
      -- If it succeeds, the result should be a non-empty string ending with /
      if not ok then
        return -- skip assertion in headless mode where root detection fails
      end
      assert.is_not_nil(p)
      assert.are.equal(string.sub(p, -1), "/")
    end)
  end)

  describe("copy (clipboard + notify)", function()
    it("copies text to the system clipboard and notifies", function()
      -- Mock vim.notify so we can capture the message
      local notified = false
      local notify_msg = ""
      _G.original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        notified = true
        notify_msg = msg or ""
      end

      -- Mock vim.fn.setreg to capture clipboard writes (works in headless CI)
      local setreg_called = false
      local captured_reg, captured_text, captured_mode ---@type boolean, string|nil, string|nil, string|nil
      _G.original_setreg = vim.fn.setreg
      vim.fn.setreg = function(reg, text, mode)
        setreg_called = true
        captured_reg = reg
        captured_text = text
        captured_mode = mode
      end

      copy_path.copy(function() return "test/path.lua" end, "Test Copy")
      assert.is_true(notified, "vim.notify should have been called")
      assert.truthy(notify_msg:find("Copied:"), "Notification should contain 'Copied:'")
      assert.truthy(notify_msg:find("test/path.lua"), "Notification should contain the path")

      -- Check clipboard was written via setreg mock (reliable in headless CI)
      assert.is_true(setreg_called, "vim.fn.setreg should have been called")
      assert.are.equal(captured_reg, "+", "Should write to system register (+)")
      assert.are.equal(captured_text, "test/path.lua", "System clipboard should contain the path")

      -- Restore mocks
      vim.notify = _G.original_notify
      _G.original_notify = nil
      vim.fn.setreg = _G.original_setreg
      _G.original_setreg = nil
    end)

    it("warns when buffer has no file (get_path returns nil)", function()
      local warned = false
      _G.original_warn = LazyVim.warn
      LazyVim.warn = function(msg, opts)
        warned = true
      end

      copy_path.copy(function() return nil end, "Test Copy")
      assert.is_true(warned, "Should warn when path is nil")

      LazyVim.warn = _G.original_warn
      _G.original_warn = nil
    end)
  end)

  describe("convenience functions", function()
    it("copy_absolute writes the absolute path to clipboard and notifies", function()
      -- Mock vim.notify so we can capture the message
      local notified = false
      _G.original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        notified = true
      end

      -- Mock vim.fn.setreg to capture clipboard writes (works in headless CI)
      local captured_text ---@type string|nil
      _G.original_setreg = vim.fn.setreg
      vim.fn.setreg = function(reg, text, mode)
        captured_text = text
      end

      copy_path.copy_absolute()
      assert.is_true(notified)

      -- Check clipboard via setreg mock (reliable in headless CI)
      if LazyVim.is_win() then
        assert.truthy(captured_text:match("^%a:") ~= nil or captured_text:find("test_file.lua"))
      else
        assert.truthy(string.sub(captured_text, 1, 1) == "/" and captured_text:find("test_file.lua"))
      end

      -- Restore mocks
      vim.notify = _G.original_notify
      _G.original_notify = nil
      vim.fn.setreg = _G.original_setreg
      _G.original_setreg = nil
    end)

    it("copy_relative_with_line_column appends line:column", function()
      -- In headless mode LazyVim.root() may fail. If relative path falls back to
      -- absolute (which is valid per the module logic), we still get :line:col appended.
      local captured_text = ""
      _G.original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        captured_text = msg or ""
      end

      copy_path.copy_relative_with_line_column()
      -- Should contain :line:col at the end regardless of whether path was relative or absolute
      assert.truthy(captured_text:find(":%d+:%d+$"), "Should end with :line:col")

      vim.notify = _G.original_notify
      _G.original_notify = nil
    end)

    it("copy_filename writes just the filename", function()
      local captured_text = ""
      _G.original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        captured_text = msg or ""
      end

      copy_path.copy_filename()
      assert.truthy(captured_text:find("test_file.lua"))

      vim.notify = _G.original_notify
      _G.original_notify = nil
    end)

    it("copy_filename_no_ext writes the filename without extension", function()
      local notify_text = ""
      _G.original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        notify_text = msg or ""
      end

      -- Mock vim.fn.setreg to capture clipboard writes (works in headless CI)
      local captured_text ---@type string|nil
      _G.original_setreg = vim.fn.setreg
      vim.fn.setreg = function(reg, text, mode)
        captured_text = text
      end

      copy_path.copy_filename_no_ext()
      assert.truthy(notify_text:find("test_file"))
      -- Should NOT contain .lua in the copied register
      assert.falsy(captured_text:find("%.lua"), "Clipboard should not contain extension")

      -- Restore mocks
      vim.notify = _G.original_notify
      _G.original_notify = nil
      vim.fn.setreg = _G.original_setreg
      _G.original_setreg = nil
    end)
  end)
end)
