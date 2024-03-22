LazyVim.lsp.on_attach(function(client, buffer)
  if client.name == "yamlls" then
    if vim.api.nvim_get_option_value("filetype", { buf = buffer }) == "helm" then
      vim.schedule(function()
        vim.cmd("LspStop ++force yamlls")
      end)
    end
  end
end)

return {
  { "towolf/vim-helm", ft = "helm" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {},
        helm_ls = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "helm-ls",
      })
    end,
  },
}
