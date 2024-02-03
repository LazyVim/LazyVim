require("lazyvim.util").lsp.on_attach(function(client, buffer)
  if client.name == "docker_compose_language_service" then
    if vim.api.nvim_get_option_value("filetype", { buf = buffer }) == "helm" then
      vim.schedule(function()
        vim.cmd("LspStop ++force docker_compose_language_service yamlls")
      end)
    end
  end
end)

return {
  "towolf/vim-helm",
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = { autostart = false },
        docker_compose_language_service = { autostart = false },
        helm_ls = {},
      },
    },
  },
}
