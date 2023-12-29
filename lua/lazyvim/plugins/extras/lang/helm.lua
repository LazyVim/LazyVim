require("lazyvim.util.lsp").on_attach(function(client, buffer)
  if client.name == "docker_compose_language_service" then
    if vim.api.nvim_buf_get_option(buffer, "filetype") == "helm" then
      vim.schedule(function()
        vim.cmd("LspStop ++force docker_compose_language_service")
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
        docker_compose_language_service = {},
        helm_ls = {},
      },
    },
  },
}
