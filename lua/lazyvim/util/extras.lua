local Config = require("lazyvim.config")
local Float = require("lazy.view.float")
local LazyConfig = require("lazy.core.config")
local Plugin = require("lazy.core.plugin")
local Text = require("lazy.view.text")
local Util = require("lazyvim.util")

---@class LazyExtra
---@field name string
---@field enabled boolean
---@field managed boolean
---@field row? number
---@field plugins string[]
---@field optional string[]

---@class lazyvim.util.extras
local M = {}

M.ns = vim.api.nvim_create_namespace("lazyvim.extras")
---@type string[]
M.state = nil

---@return LazyExtra[]
function M.get()
  M.state = M.state or LazyConfig.spec.modules
  local root = LazyConfig.plugins.LazyVim.dir .. "/lua/lazyvim/plugins/extras"
  local extras = {} ---@type string[]

  Util.walk(root, function(path, name, type)
    if type == "file" and name:match("%.lua$") then
      local extra = path:sub(#root + 2, -5):gsub("/", ".")
      extras[#extras + 1] = extra
    end
  end)
  table.sort(extras)

  ---@param extra string
  return vim.tbl_map(function(extra)
    local modname = "lazyvim.plugins.extras." .. extra
    local enabled = vim.tbl_contains(M.state, modname)
    local spec = Plugin.Spec.new({ import = "lazyvim.plugins.extras." .. extra }, { optional = true })
    local plugins = {} ---@type string[]
    local optional = {} ---@type string[]
    for _, p in pairs(spec.plugins) do
      if p.optional then
        optional[#optional + 1] = p.name
      else
        plugins[#plugins + 1] = p.name
      end
    end
    table.sort(plugins)
    table.sort(optional)

    return {
      name = extra,
      enabled = enabled,
      managed = vim.tbl_contains(Config.json.data.extras, extra) or not enabled,
      plugins = plugins,
      optional = optional,
    }
  end, extras)
end

---@class LazyExtraView
---@field float LazyFloat
---@field text Text
---@field extras LazyExtra[]
---@field diag LazyDiagnostic[]
local X = {}

---@return LazyExtraView
function X.new()
  local self = setmetatable({}, { __index = X })
  self.float = Float.new({ title = "LazyVim Extras" })
  self.float:on_key("x", function()
    self:toggle()
  end, "Toggle extra")
  self.diag = {}
  self:update()
  return self
end

---@param diag LazyDiagnostic
function X:diagnostic(diag)
  diag.row = diag.row or self.text:row()
  diag.severity = diag.severity or vim.diagnostic.severity.INFO
  table.insert(self.diag, diag)
end

function X:toggle()
  local pos = vim.api.nvim_win_get_cursor(self.float.win)
  for _, extra in ipairs(self.extras) do
    if extra.row == pos[1] then
      if not extra.managed then
        Util.error(
          "Not managed by LazyExtras. Remove from your config to enable/disable here.",
          { title = "LazyExtras" }
        )
        return
      end
      extra.enabled = not extra.enabled
      Config.json.data.extras = vim.tbl_filter(function(name)
        return name ~= extra.name
      end, Config.json.data.extras)
      M.state = vim.tbl_filter(function(name)
        return name ~= "lazyvim.plugins.extras." .. extra.name
      end, M.state)
      if extra.enabled then
        table.insert(Config.json.data.extras, extra.name)
        M.state[#M.state + 1] = "lazyvim.plugins.extras." .. extra.name
      end
      table.sort(Config.json.data.extras)
      Config.json.save()
      Util.info(
        "`"
          .. extra.name
          .. "`"
          .. " "
          .. (extra.enabled and "**enabled**" or "**disabled**")
          .. "\nPlease restart LazyVim to apply the changes.",
        { title = "LazyExtras" }
      )
      self:update()
      return
    end
  end
end

function X:update()
  self.diag = {}
  self.extras = M.get()
  self.text = Text.new()
  self.text.padding = 2
  self:render()
  self.text:trim()
  vim.bo[self.float.buf].modifiable = true
  self.text:render(self.float.buf)
  vim.bo[self.float.buf].modifiable = false
  vim.diagnostic.set(
    M.ns,
    self.float.buf,
    ---@param diag LazyDiagnostic
    vim.tbl_map(function(diag)
      diag.col = 0
      diag.lnum = diag.row - 1
      return diag
    end, self.diag),
    { signs = false, virtual_text = true }
  )
end

function X:render()
  self.text:nl():nl():append("LazyVim Extras", "LazyH1"):nl():nl()
  self.text
    :append("This is a list of all enabled/disabled LazyVim extras.", "LazyComment")
    :nl()
    :append("Each extra shows the required and optional plugins it may install.", "LazyComment")
    :nl()
    :append("Enable/disable extras with the ", "LazyComment")
    :append("<x>", "LazySpecial")
    :append(" key", "LazyComment")
    :nl()
  self:section({ enabled = true, title = "Enabled" })
  self:section({ enabled = false, title = "Disabled" })
end

---@param extra LazyExtra
function X:extra(extra)
  if not extra.managed then
    self:diagnostic({
      message = "Not managed by LazyExtras (config)",
      severity = vim.diagnostic.severity.WARN,
    })
  end
  extra.row = self.text:row()
  local hl = extra.managed and "LazySpecial" or "LazyLocal"
  if extra.enabled then
    self.text:append("  " .. LazyConfig.options.ui.icons.loaded .. " ", hl)
  else
    self.text:append("  " .. LazyConfig.options.ui.icons.not_loaded .. " ", hl)
  end
  self.text:append(extra.name)
  for _, plugin in ipairs(extra.plugins) do
    self.text:append(" "):append(LazyConfig.options.ui.icons.plugin .. "" .. plugin, "LazyReasonPlugin")
  end
  for _, plugin in ipairs(extra.optional) do
    self.text:append(" "):append(LazyConfig.options.ui.icons.plugin .. "" .. plugin, "LazyReasonRequire")
  end
  self.text:nl()
end

---@param opts {enabled?:boolean, title?:string}
function X:section(opts)
  opts = opts or {}
  ---@type LazyExtra[]
  local extras = vim.tbl_filter(function(extra)
    return opts.enabled == nil or extra.enabled == opts.enabled
  end, self.extras)

  self.text:nl():append(opts.title .. ":", "LazyH2"):append(" (" .. #extras .. ")", "LazyComment"):nl()
  for _, extra in ipairs(extras) do
    self:extra(extra)
  end
end

function M.show()
  return X.new()
end

return M
