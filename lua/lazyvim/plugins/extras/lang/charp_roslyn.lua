local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local on_attach = function() end
return {
  {
    "jmederosalvarado/roslyn.nvim",
    ft = "cs",
    config = function()
      require("roslyn").setup({

        dotnet_cmd = "dotnet", -- this is the default
        roslyn_version = "4.8.0-3.23475.7", -- this is the default
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}
