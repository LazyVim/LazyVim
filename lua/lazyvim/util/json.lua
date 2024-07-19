---@class lazyvim.util.json
local M = {}

---@param value any
---@param indent string
local function encode(value, indent)
  local t = type(value)

  if t == "string" then
    return string.format("%q", value)
  elseif t == "number" or t == "boolean" then
    return tostring(value)
  elseif t == "table" then
    local is_list = LazyVim.is_list(value)
    local parts = {}
    local next_indent = indent .. "  "

    if is_list then
      ---@diagnostic disable-next-line: no-unknown
      for _, v in ipairs(value) do
        local e = encode(v, next_indent)
        if e then
          table.insert(parts, next_indent .. e)
        end
      end
      return "[\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "]"
    else
      local keys = vim.tbl_keys(value)
      table.sort(keys)
      ---@diagnostic disable-next-line: no-unknown
      for _, k in ipairs(keys) do
        local e = encode(value[k], next_indent)
        if e then
          table.insert(parts, next_indent .. string.format("%q", k) .. ": " .. e)
        end
      end
      return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "}"
    end
  end
end

function M.encode(value)
  return encode(value, "")
end

function M.save()
  LazyVim.config.json.data.version = LazyVim.config.json.version
  local f = io.open(LazyVim.config.json.path, "w")
  if f then
    f:write(LazyVim.json.encode(LazyVim.config.json.data))
    f:close()
  end
end

function M.migrate()
  LazyVim.info("Migrating `lazyvim.json` to version `" .. LazyVim.config.json.version .. "`")
  local json = LazyVim.config.json

  -- v0
  if not json.data.version then
    if json.data.hashes then
      ---@diagnostic disable-next-line: no-unknown
      json.data.hashes = nil
    end
    json.data.extras = vim.tbl_map(function(extra)
      return "lazyvim.plugins.extras." .. extra
    end, json.data.extras or {})
  elseif json.data.version == 1 then
    json.data.extras = vim.tbl_map(function(extra)
      -- replace double extras module name
      return extra:gsub("^lazyvim%.plugins%.extras%.lazyvim%.plugins%.extras%.", "lazyvim.plugins.extras.")
    end, json.data.extras or {})
  elseif json.data.version == 2 then
    json.data.extras = vim.tbl_map(function(extra)
      return extra == "lazyvim.plugins.extras.editor.symbols-outline" and "lazyvim.plugins.extras.editor.outline"
        or extra
    end, json.data.extras or {})
  elseif json.data.version == 3 then
    json.data.extras = vim.tbl_filter(function(extra)
      return not (
        extra == "lazyvim.plugins.extras.coding.mini-ai"
        or extra == "lazyvim.plugins.extras.ui.treesitter-rewrite"
      )
    end, json.data.extras or {})
  elseif json.data.version == 4 then
    json.data.extras = vim.tbl_filter(function(extra)
      return not (extra == "lazyvim.plugins.extras.lazyrc")
    end, json.data.extras or {})
  elseif json.data.version == 5 then
    json.data.extras = vim.tbl_filter(function(extra)
      return not (extra == "lazyvim.plugins.extras.editor.trouble-v3")
    end, json.data.extras or {})
  end

  M.save()
end

return M
