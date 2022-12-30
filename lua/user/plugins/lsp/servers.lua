---@type lspconfig.options
local servers = {
  bashls = {},
  clangd = {},
  cssls = {},
  tsserver = {},
  html = {},
  jsonls = {},
  pyright = {},
  yamlls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
}

return servers
