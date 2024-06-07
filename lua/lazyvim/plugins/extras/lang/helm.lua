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
  recommended = function()
    return LazyVim.extras.wants({
      ft = "helm",
      root = "Chart.yaml",
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "helm" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {},
        helm_ls = {},
      },
    },
  },
}
