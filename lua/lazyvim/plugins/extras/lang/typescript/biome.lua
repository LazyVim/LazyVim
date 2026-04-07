---@module "conform"

---@diagnostic disable: inject-field
if lazyvim_docs then
  -- Enable this option to avoid conflicts with Prettier.
  vim.g.lazyvim_prettier_needs_config = true
end

-- https://biomejs.dev/internals/language-support/
local supported = {
  "astro",
  "css",
  "scss",
  "graphql",
  -- "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  -- "markdown",
  "svelte",
  "typescript",
  "typescriptreact",
  "vue",
  -- "yaml",
}

return {
  recommended = function()
    return LazyVim.extras.wants({
      root = { "biome.json", "biome.jsonc" },
    })
  end,

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ---@type lspconfig.settings.biome
        biome = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "biome-check")
      end

      opts.formatters = opts.formatters or {}
      opts.formatters["biome-check"] = {
        require_cwd = true,
      }
    end,
  },

  -- none-ls support
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.biome)
    end,
  },
}
