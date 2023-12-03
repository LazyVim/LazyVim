--[[
This extra allows for project-specific plugin specs.

File .lazy.lua:
  is read when present in the current working directory
  should return a plugin spec
  has to be manually trusted for each instance of the file

This extra should be the last plugin spec parsed by lazy.nvim

See:
  :h 'exrc'
  :h :trust
--]]
local filepath = vim.fn.fnamemodify(".lazy.lua", ":p")
local file = vim.secure.read(filepath)
if not file then
  return {}
end
return loadstring(file)()
