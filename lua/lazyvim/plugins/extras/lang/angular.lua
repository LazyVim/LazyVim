local angular_root_pattern = { "angular.json", "project.json" }

return {
  recommended = function()
    return LazyVim.extras.wants({
      root = {
        "angular.json",
        "project.json", --support for angular monorepo workspace
      },
    })
  end,

  {
    "nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular", "scss" })
      end
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.component.html", "*.container.html", "*.component.svg", "*.container.svg" },
        callback = function()
          vim.treesitter.start(nil, "angular")
        end,
      })
    end,
  },

  -- angularls depends on typescript
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          root_dir = function(root_dir)
            return require("lspconfig.util").root_pattern(unpack(angular_root_pattern))(root_dir)
          end,
          keys = {
            {
              "<leader>cr",
              function()
                vim.lsp.buf.rename(nil, {
                  filter = function(client)
                    return client.name == "angularls"
                  end,
                })
              end,
              desc = "Rename",
            },
          },
        },
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@angular/language-server",
          location = LazyVim.get_pkg_path("angular-language-server", "/node_modules/@angular/language-server"),
          enableForWorkspaceTypeScriptVersions = false,
        },
      })
    end,
  },
}
