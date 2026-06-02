if lazyvim_docs then
  -- Formatter to use for MATLAB.
  -- Set to "miss_hit" to use mh_style instead of matlab_ls.
  vim.g.lazyvim_matlab_formatter = "lsp"
end

local formatter = vim.g.lazyvim_matlab_formatter or "lsp"

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "matlab",
      root = { "*.prj" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "matlab" } },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if formatter == "miss_hit" then
        vim.list_extend(opts.ensure_installed, { "miss_hit" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        matlab_ls = {},
      },
    },
  },
  -- tmux required
  {
    "idossha/matlab.nvim",
    ft = "matlab",
    opts = {
      auto_start = false,
      default_mappings = true,
      mappings = {
        prefix = "<localleader>m",
      },
    },
  },
  -- `mh_style` from `miss_hit`
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      if formatter == "miss_hit" then
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        opts.formatters_by_ft.matlab = { "mh_style" }
      end
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<localleader>m", group = "MATLAB", icon = { icon = "" } },
        { "<localleader>md", group = "debug" },
      },
    },
  },
}
