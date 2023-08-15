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

  -- Set up lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        jdtls = {},
      },
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,
      },
    },
  },

  -- Set up nvim-jdtls
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    ft = { "java" },
    config = function()
      -- The configuration for jdtls contains two useful items:
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
          java_test_path .. "/extension/server/*.jar",
        }
        for _, jar_pattern in ipairs(jar_patterns) do
          for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
            table.insert(bundles, bundle)
          end
        end
      end

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
        cmd = cmd,
        root_dir = root_dir,
        init_options = {
          bundles = bundles,
        },
        -- enable CMP capabilities
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      -- Attach jdtls for the proper filetypes (i.e. java).
      -- Existing server will be reused if the root_dir matches.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
          local jdtls_opts = require("lazyvim.util").opts("nvim-jdtls")
          require("jdtls").start_or_attach(vim.tbl_deep_extend("force", jdtls_opts or {}, jdtls_base_config))
          -- not need to require("jdtls.setup").add_commands(), start automatically adds commands
        end,
      })

      -- Setup keymap and dap after the lsp is fully attached
      -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
      -- https://neovim.io/doc/user/lsp.html#LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          --  only after the jdtls client is attached
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.name == "jdtls" then
            require("which-key").register({
              ["<leader>cx"] = { name = "+extract" },
              ["<leader>cxv"] = { require("jdtls").extract_variable_all, "Extract Variable" },
              ["<leader>cxc"] = { require("jdtls").extract_constant, "Extract Constant" },
              ["gs"] = { require("jdtls").super_implementation, "Goto Super" },
              ["gS"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
              ["<leader>co"] = { require("jdtls").organize_imports, "Organize Imports" },
            }, { mode = "n", buffer = args.buf })
            require("which-key").register({
              ["<leader>c"] = { name = "+code" },
              ["<leader>cx"] = { name = "+extract" },
              ["<leader>cxm"] = { [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], "Extract Method" },
              ["<leader>cxv"] = {
                [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
                "Extract Variable",
              },
              ["<leader>cxc"] = { [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]], "Extract Constant" },
            }, { mode = "v", buffer = args.buf })

            if mason_registry.has_package("java-debug-adapter") then
              -- custom init for Java debugger
              require("jdtls").setup_dap({ hotcodereplace = "auto", config_overrides = {} })
              require("jdtls.dap").setup_dap_main_class_configs()

              -- Java Test require Java debugger to work
              if mason_registry.has_package("java-test") then
                -- custom keymaps for Java test runner (not yet compatible with neotest)
                require("which-key").register({
                  ["<leader>t"] = { name = "+test" },
                  ["<leader>tt"] = { require("jdtls.dap").test_class, "Run All Test" },
                  ["<leader>tr"] = { require("jdtls.dap").test_nearest_method, "Run Nearest Test" },
                  ["<leader>tT"] = { require("jdtls.dap").pick_test, "Run Test" },
                }, { mode = "n", buffer = args.buf })
              end
            end
          end
        end,
      })
    end,
  },
}
