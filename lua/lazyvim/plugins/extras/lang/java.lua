return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "java",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "jdtls",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
          ensure_installed = {
            "javadbg",
            "javatest",
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        jdtls = function()
          return true
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "hrsh7th/nvim-cmp",
      "folke/which-key.nvim",
    },
    ft = { "java" },
    config = function()
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"),
          "-configuration",
          vim.fn.expand("$MASON/share/jdtls/config"),
          "-data",
          workspace_dir,
        },
        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
        settings = {
          java = {},
        },
        handlers = {
          ["$/progress"] = function() end,
          ["language/status"] = function() end,
        },
        init_options = {
          bundles = {
            vim.fn.expand("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
            (table.unpack or unpack)(vim.split(vim.fn.glob("$MASON/share/java-test/*.jar"), "\n", {})),
          },
        },
        filetypes = { "java" },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          require("jdtls").start_or_attach(config)
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.java",
        callback = function(args)
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
            ["<leader>cxv"] = { [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]], "Extract Variable" },
            ["<leader>cxc"] = { [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]], "Extract Constant" },
          }, { mode = "v", buffer = args.buf })

          require("jdtls.dap").setup_dap()
          require("jdtls.dap").setup_dap_main_class_configs()

          require("which-key").register({
            ["<leader>t"] = { name = "+test" },
            ["<leader>tT"] = { require("jdtls.dap").test_class, "Run All Test" },
            ["<leader>tr"] = { require("jdtls.dap").test_nearest_method, "Run Nearest Test" },
            ["<leader>tt"] = { require("jdtls.dap").pick_test, "Run Test" },
          }, { mode = "n", buffer = args.buf })
        end,
      })
    end,
  },
}
