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
        injected = { options = { ignore_errors = true } },
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
      for name, formatter in pairs(opts.formatters) do
        if type(formatter) == "table" then
          local ok, defaults = pcall(require, "conform.formatters." .. name)
          if ok and type(defaults) == "table" then
            opts.formatters[name] = vim.tbl_deep_extend("force", {}, defaults, formatter)
          end
        end
      end
      require("conform").setup(opts)
    end,
  },
}
