local Config = require("lazyvim.config")
local Util = require("lazyvim.util")

---@class lazyvim.util.news
local M = {}

function M.hash(file)
  local stat = vim.loop.fs_stat(file)
  if not stat then
    return
  end
  return stat.size .. ""
end

function M.setup()
  vim.schedule(function()
    if Config.news.lazyvim then
      if not Config.json.data.news["NEWS.md"] then
        M.welcome()
      end
      M.lazyvim(true)
    end
    if Config.news.neovim then
      M.neovim(true)
    end
  end)
end

function M.welcome()
  Util.info("Welcome to LazyVim!")
end

function M.changelog()
  M.open("CHANGELOG.md", { plugin = "LazyVim" })
end

function M.lazyvim(when_changed)
  M.open("NEWS.md", { plugin = "LazyVim", when_changed = when_changed })
end

function M.neovim(when_changed)
  M.open("doc/news.txt", { rtp = true, when_changed = when_changed })
end

---@param file string
---@param opts? {plugin?:string, rtp?:boolean, when_changed?:boolean}
function M.open(file, opts)
  local ref = file
  opts = opts or {}
  if opts.plugin then
    local plugin = require("lazy.core.config").plugins[opts.plugin] --[[@as LazyPlugin?]]
    if not plugin then
      return Util.error("plugin not found: " .. opts.plugin)
    end
    file = plugin.dir .. "/" .. file
  elseif opts.rtp then
    file = vim.api.nvim_get_runtime_file(file, false)[1]
  end

  if not file then
    return Util.error("File not found")
  end

  if opts.when_changed then
    local is_new = not Config.json.data.news[ref]
    local hash = M.hash(file)
    if hash == Config.json.data.news[ref] then
      return
    end
    Config.json.data.news[ref] = hash
    Util.json.save()
    -- don't open if file has never been opened
    if is_new then
      return
    end
  end

  local float = require("lazy.util").float({
    file = file,
    size = { width = 0.6, height = 0.6 },
  })
  vim.opt_local.spell = false
  vim.opt_local.wrap = false
  vim.opt_local.signcolumn = "yes"
  vim.opt_local.statuscolumn = " "
  vim.opt_local.conceallevel = 3
  vim.diagnostic.disable(float.buf)
end

return M
