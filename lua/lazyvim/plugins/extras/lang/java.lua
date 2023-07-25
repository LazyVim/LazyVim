return {
  -- Add java to treesitter.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "java" })
      end
    end,
  },

  -- Ensure java debugger and test packages are installed
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "java-test", "java-debug-adapter" })
        end,
      },
    },
  },

  -- Set up lsp with mfussenegger/nvim-jdtls instead of nvim-lspconfig.
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/which-key.nvim", "mfussenegger/nvim-jdtls" },
    opts = {
      -- make sure mason installs the server
      servers = {
        jdtls = {
          -- stylua: ignore
          keys = {
            { "<leader>co", function() require("jdtls").organize_imports() end, desc = "Organize Imports", },
            { "<leader>cR", function() require("jdtls").rename_file() end, desc = "Rename File", },
            { "<leader>cxv", function() require("jdtls").extract_variable() end, desc = "Extract Variable", },
            { "<leader>cxv", function() require("jdtls").extract_variable({ visual = true }) end, mode = "v", desc = "Extract Variable", },
            { "<leader>cxc", function() require("jdtls").extract_constant() end, desc = "Extract Constant", },
            { "<leader>cxc", function() require("jdtls").extract_constant({ visual = true }) end, mode = "v", desc = "Extract Constant", },
            { "<leader>cxm", function() require("jdtls").extract_method({ visual = true }) end, mode = "v", desc = "Extract Method", },
          },
        },
      },
      setup = {
        -- Override the default jdtls server startup to use nvim-jdtls.
        jdtls = function()
          -- The lspconfig configuration for jdtls contains two useful items:
          -- 1. The list of filetypes on which to match.
          -- 2. Custom method for finding the root for a java project.
          local lsp_config = require("lspconfig.server_configurations.jdtls").default_config
          local find_java_project_root = lsp_config.root_dir
          local filetypes = lsp_config.filetypes
          -- lookup paths for java test and debugger package
          local mason_registry = require("mason-registry")
          local bundles = {}
          if mason_registry.has_package("java-test") and mason_registry.has_package("java-debug-adapter") then
            -- jdtls tools configuration for debugging support
            local java_test_pkg = mason_registry.get_package("java-test")
            local java_test_path = java_test_pkg:get_install_path()
            local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
            local java_dbg_path = java_dbg_pkg:get_install_path()
            local jar_patterns = {
              java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
              java_test_path .. "/extension/server/*.jar"
            }
            for _, jar_pattern in ipairs(jar_patterns) do
              for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), '\n')) do
                table.insert(bundles, bundle)
              end
            end
          end
          -- Attach jdtls for the proper filetypes (i.e. java).
          -- Existing server will be reused if the root_dir matches.
          vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("MyJdtls", { clear = true }),
            pattern = filetypes,
            callback = function()
              local fname = vim.api.nvim_buf_get_name(0)
              local root_dir = find_java_project_root(fname)
              local project_name = root_dir and vim.fs.basename(root_dir)
              local cmd = { "jdtls" }
              if project_name then
                local jdtls_cache_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name
                vim.list_extend(cmd, {
                  "-configuration",
                  jdtls_cache_dir .. "/config",
                  "-data",
                  jdtls_cache_dir .. "/workspace",
                })
              end
              local jdtls_base_config = {
                on_attach = require("lazyvim.util").on_attach(function(client, buffer)
                  if mason_registry.has_package("java-test") then
                    -- custom keymaps for Java test runner (not yet compatible with neotest)
                    vim.keymap.set("n", "<leader>tT", function() require("jdtls").pick_test({ bufnr = buffer }) end, { buffer = buffer, desc = "Run specific Test" })
                    vim.keymap.set("n", "<leader>tt", function() require("jdtls").test_class({ bufnr = buffer }) end, { buffer = buffer, desc = "Run File" })
                    vim.keymap.set("n", "<leader>tr", function() require("jdtls").test_nearest_method({ bufnr = buffer }) end, { buffer = buffer, desc = "Run nearest" })
                  end
                  if mason_registry.has_package("java-debug-adapter") then
                    -- custom init for Java debugger
                    require("jdtls").setup_dap({ hotcodereplace = "auto" })
                    require("jdtls.dap").setup_dap_main_class_configs()
                  end
                  require("jdtls.setup").add_commands()
                end),
                cmd = cmd,
                root_dir = root_dir,
                init_options = {
                  bundles = bundles,
                }
              }
              local jdtls_opts = require("lazyvim.util").opts("nvim-jdtls")
              require("jdtls").start_or_attach(vim.tbl_deep_extend("force", jdtls_opts or {}, jdtls_base_config))
              require("which-key").register({ c = { x = { name = "Extract" } } }, { prefix = "<leader>" })
            end,
          })
          return true -- avoid duplicate servers
        end,
      },
    },
  },
}
