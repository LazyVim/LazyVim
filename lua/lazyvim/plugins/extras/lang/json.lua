return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "json", "jsonc", "json5" },
      root = { "*.json" },
    })
  end,

  -- add json to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json5" } },
  },

  -- yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },

  -- add json-nvim for alternative
  {
    "VPavliashvili/json-nvim", -- requires jq (installed with mason later)
    ft = "json",
    keys = {
      { "<localleader>e", "<cmd>JsonEscapeFile<cr>", ft = "json", desc = "Escape JSON in entire file" },
      { "<localleader>E", "<cmd>JsonEscapeSelection<cr>", ft = "json", desc = "Escape JSON in selected text" },
      { "<localleader>f", "<cmd>JsonFormatFile<cr>", ft = "json", desc = "Format JSON in entire file" },
      { "<localleader>F", "<cmd>JsonFormatSelection<cr>", ft = "json", desc = "Format JSON in selected text" },
      { "<localleader>t", "<cmd>JsonFormatToken<cr>", ft = "json", desc = "Format JSON token under cursor" },
      { "<localleader>c", "<cmd>JsonKeysToCamelCase<cr>", ft = "json", desc = "Convert JSON keys to camelCase" },
      { "<localleader>p", "<cmd>JsonKeysToPascalCase<cr>", ft = "json", desc = "Convert JSON keys to PascalCase" },
      { "<localleader>s", "<cmd>JsonKeysToSnakeCase<cr>", ft = "json", desc = "Convert JSON keys to snake_case" },
      { "<localleader>m", "<cmd>JsonMinifyFile<cr>", ft = "json", desc = "Minify JSON in entire file" },
      { "<localleader>M", "<cmd>JsonMinifySelection<cr>", ft = "json", desc = "Minify JSON in selected text" },
      { "<localleader>u", "<cmd>JsonUnescapeFile<cr>", ft = "json", desc = "Unescape JSON in entire file" },
      { "<localleader>U", "<cmd>JsonUnescapeSelection<cr>", ft = "json", desc = "Unescape JSON in selected text" },
    },
  },

  -- ensure mason installs jq (formatter)
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "jq", -- formatter
      })
    end,
  },
}
