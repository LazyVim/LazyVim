if lazyvim_docs then
  -- Enable the option to require an oxfmt config file
  -- If no oxfmt config file is found, the formatter will not be used
  vim.g.lazyvim_oxfmt_needs_config = false
end

local M = {}

local supported = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "vue",
  "svelte",
  "astro",
}

local oxfmt_markers = {
  ".oxfmtrc.json",
  ".oxfmtrc.jsonc",
  "oxfmt.config.ts",
}

local oxlint_markers = {
  ".oxlintrc.json",
  ".oxlintrc.jsonc",
  "oxlint.config.ts",
}

--- Checks if a oxfmt config file exists for the given context
---@module 'conform'
---@param ctx conform.Context
---@return boolean
function M.has_oxfmt_config(ctx)
  return vim.fs.root(ctx.buf, oxfmt_markers) ~= nil
end

M.has_oxfmt_config = LazyVim.memoize(M.has_oxfmt_config)

return {
  recommended = function()
    return LazyVim.extras.wants({
      root = vim.list_extend(vim.list_extend({}, oxlint_markers), oxfmt_markers),
    })
  end,

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ---@type lspconfig.settings.oxlint
        oxlint = {
          root_dir = function(bufnr, on_dir)
            -- prefer the top-level oxlint config if it exists (monorepo support)
            local git = vim.fs.root(bufnr, ".git")
            local root = git and vim.fs.root(git, oxlint_markers) or vim.fs.root(bufnr, oxlint_markers)
            if root then
              on_dir(root)
            end
          end,
          settings = {
            fixKind = "all",
          },
        },
        --- disable the oxfmt lsp server since we use conform for formatting
        oxfmt = { enabled = false },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxfmt" } },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "oxfmt")
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = {
        condition = function(_, ctx)
          return vim.g.lazyvim_oxfmt_needs_config ~= true or M.has_oxfmt_config(ctx)
        end,
      }
    end,
  },
}
