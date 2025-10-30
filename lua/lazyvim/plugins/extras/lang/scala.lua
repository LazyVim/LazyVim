return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "scala",
      root = { "build.sbt", "build.sc", "build.gradle", "pom.xml" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "scala" } },
  },
  {
    "scalameta/nvim-metals",
    keys = {
      {
        "<localleader>e",
        function()
          require("metals").commands()
        end,
        ft = { "scala", "sbt", "java" },
        desc = "Metals commands",
      },
      {
        "<localleader>c",
        function()
          require("metals").compile_cascade()
        end,
        desc = "Metals compile cascade",
      },
      {
        "<localleader>h",
        function()
          require("metals").hover_worksheet()
        end,
        desc = "Metals hover worksheet",
      },
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()

      metals_config.init_options.statusBarProvider = "off"

      metals_config.settings = {
        verboseCompilation = true,
        showImplicitArguments = false,
        showImplicitConversionsAndClasses = false,
        showInferredType = true,
        superMethodLensesEnabled = true,
        excludedPackages = {
          "akka.actor.typed.javadsl",
          "org.apache.pekko.actor.typed.javadsl",
          "com.github.swagger.akka.javadsl",
        },
        testUserInterface = "Test Explorer",
      }

      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
        require("metals").setup_dap()
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      -- Debug settings
      local dap = require("dap")
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "RunOrTest",
          metals = {
            runType = "runOrTestFile",
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }
    end,
  },
}
