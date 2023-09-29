-- When `conform.nvim` is enabled, it will automatically be used as the
-- formatter for all files that it supports.
-- When no conform formatter is available for a filetype, LSP format
-- will be used instead.
--
-- LazyVim adds a custom `formatter_opts` option to allow overriding the
-- default options for each formatter.
return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    init = function()
      -- Install the conform formatter on VeryLazy
      require("lazyvim.util").on_very_lazy(function()
        require("lazyvim.plugins.lsp.format").custom_format = function(buf)
          return require("conform").format({ bufnr = buf })
        end
      end)
    end,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
      -- LazyVim extension to easily override formatter options
      ---@type table<string,table>
      formatter_opts = {
        -- -- Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
    config = function(_, opts)
      opts.formatters = opts.formatters or {}
      for f, o in pairs(opts.formatter_opts or {}) do
        opts.formatters[f] = vim.tbl_deep_extend("force", require("conform.formatters." .. f), o)
      end
      require("conform").setup(opts)
    end,
  },
}
