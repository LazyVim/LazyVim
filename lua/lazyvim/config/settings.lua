require("lazy.core.util").warn(
  [[`config.settings` is deprecated.

Please configure LazyVim as a plugin:
```lua
{
  "LazyVim/LazyVim",
  opts = {
    -- your config comes here
  },
}
```
]],
  { title = "LazyVim" }
)
return require("lazyvim.config")
