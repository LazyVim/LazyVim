---@class lazyvim.util.lazygit
local M = {}

-- stylua: ignore
M.remote_patterns = {
  { "^(https?://.*)%.git$"              , "%1" },
  { "^git@(.+):(.+)%.git$"              , "https://%1/%2" },
  { "^git@(.+):(.+)$"                   , "https://%1/%2" },
  { "^git@(.+)/(.+)$"                   , "https://%1/%2" },
  { "^ssh://git@(.*)$"                  , "https://%1" },
  { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
  { "^https://%w*@(.*)"                 , "https://%1" },
  { "^git@(.*)"                         , "https://%1" },
  { ":%d+"                              , "" },
  { "%.git$"                            , "" },
}

---@param remote string
function M.get_url(remote)
  local ret = remote
  for _, pattern in ipairs(M.remote_patterns) do
    ret = ret:gsub(pattern[1], pattern[2])
  end
  return ret:find("https://") == 1 and ret or ("https://%s"):format(ret)
end

function M.browse()
  local lines = require("lazy.manage.process").exec({ "git", "remote", "-v" })
  local remotes = {} ---@type {name:string, url:string}[]

  for _, line in ipairs(lines) do
    local name, remote = line:match("(%S+)%s+(%S+)%s+%(fetch%)")
    if name and remote then
      local url = M.get_url(remote)
      if url then
        table.insert(remotes, {
          name = name,
          url = url,
        })
      end
    end
  end

  local function open(remote)
    if remote then
      LazyVim.info(("Opening [%s](%s)"):format(remote.name, remote.url))
      if vim.fn.has("nvim-0.10") == 0 then
        require("lazy.util").open(remote.url, { system = true })
        return
      end
      vim.ui.open(remote.url)
    end
  end

  if #remotes == 0 then
    return LazyVim.error("No git remotes found")
  elseif #remotes == 1 then
    return open(remotes[1])
  end

  vim.ui.select(remotes, {
    prompt = "Select remote to browse",
    format_item = function(item)
      return item.name .. (" "):rep(8 - #item.name) .. " 🔗 " .. item.url
    end,
  }, open)
end

return M
