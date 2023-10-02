return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
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
      -- LazyVim will merge the options you set here with builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string,table>
      formatters = {
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
      for f, o in pairs(opts.formatters) do
        local ok, formatter = pcall(require, "conform.formatters." .. f)
        opts.formatters[f] = vim.tbl_deep_extend("force", {}, ok and formatter or {}, o)
      end
      require("conform").setup(opts)
    end,
  },
}
