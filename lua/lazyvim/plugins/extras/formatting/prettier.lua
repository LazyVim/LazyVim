if lazyvim_docs then
  -- By default, prettier will only be used for formatting
  -- if a prettier configuration file is found in the project.
  -- Set to `false` to always use prettier for supported filetypes.
  vim.g.lazyvim_prettier_needs_config = true
end

local needs_config = vim.g.lazyvim_prettier_needs_config ~= false

-- local check = vim.g.lazyvim_prettier

local enabled = {} ---@type table<string, boolean>

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "prettier")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.prettier)
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
        ["svelte"] = { "prettier" },
      },
      formatters = {
        prettier = {
          condition = function(_, ctx)
            if not needs_config then
              return true
            end
            if enabled[ctx.filename] == nil then
              vim.fn.system({ "prettier", "--find-config-path", ctx.filename })
              enabled[ctx.filename] = vim.v.shell_error == 0
            end
            return enabled[ctx.filename]
          end,
        },
      },
    },
  },
}
