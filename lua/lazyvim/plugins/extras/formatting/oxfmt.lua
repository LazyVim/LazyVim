---@diagnostic disable: inject-field
if lazyvim_docs then
  -- Enable the option to require an oxfmt config file.
  -- If no oxfmt config file is found, the formatter will not be used.
  -- Note: oxfmt is Prettier-compatible but uses its own config files
  -- (.oxfmtrc.json or .oxfmtrc.jsonc), not Prettier configs.
  vim.g.lazyvim_oxfmt_needs_config = false
end

-- https://oxc.rs/docs/guide/usage/formatter.html#supported-languages
local supported = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

---@param ctx conform.Context
local function has_config(ctx)
  return vim.fs.find({ ".oxfmtrc.json", ".oxfmtrc.jsonc" }, { path = ctx.filename, upward = true })[1] ~= nil
end

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxfmt" } },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "oxfmt")
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = {
        condition = function(_, ctx)
          return vim.g.lazyvim_oxfmt_needs_config ~= true or has_config(ctx)
        end,
      }
    end,
  },
}
