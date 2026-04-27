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

return {
  recommended = function()
    return LazyVim.extras.wants({
      root = {
        ".oxlintrc.json",
        ".oxlintrc.jsonc",
        "oxlint.config.ts",
        ".oxfmtrc.json",
        ".oxfmtrc.jsonc",
        "oxfmt.config.ts",
      },
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
            local markers = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" }
            local root = git and vim.fs.root(git, markers) or vim.fs.root(bufnr, markers)
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
    end,
  },
}
