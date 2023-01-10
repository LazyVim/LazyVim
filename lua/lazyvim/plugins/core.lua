local specs = {
  -- set to HEAD for now. I'm sill making too many changes for this repo related to lazy itself
  { "folke/lazy.nvim", version = false },
}

-- only add for >=9.0.1, since there's an endless loop in earlier versions
if require("lazyvim.config").has(">=9.1.0") then
  specs[#specs + 1] = { "LazyVim/LazyVim", priority = 10000, lazy = false, config = true }
else
  require("lazyvim.config").setup()
end

return specs
