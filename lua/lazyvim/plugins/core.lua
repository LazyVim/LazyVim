-- only add for >=9.0.1, since there's an endless loop in earlier versions
if not require("lazyvim.config").has(">=9.1.0") then
  require("lazyvim.config").setup()
  return {}
end

return {
  { "LazyVim/LazyVim", priority = 10000, lazy = false, config = true },
}
