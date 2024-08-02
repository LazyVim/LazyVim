-- Simple check to see if the user has lazygit installed. Only then use keymaps.
gitcheck = {}
function gitcheck.is_lazygit_available()
  local handle = io.popen("lazygit --version")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
  end
  return false
end
return gitcheck 