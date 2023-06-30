return {

  -- Extend auto completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = true,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "crates" },
      }))
    end,
  },

  -- Add Rust & related to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
      end
    end,
  },

  -- Ensure Rust debugger is installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
    end,
  },

  -- Correctly setup lspconfig for Rust 🚀
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
      -- Avoid calling setup twice if user supplies `opts`
      config = function() end,
    },
    opts = {
      servers = {
        -- Ensure mason installs the server
        rust_analyzer = {},
        taplo = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "rust_analyzer" then
              vim.keymap.set("n", "K", "<cmd>RustHoverActions<cr>", { buffer = buffer, desc = "Hover Actions (Rust)" })
              vim.keymap.set( "n", "<leader>cR", "<cmd>RustCodeAction<cr>", { buffer = buffer, desc = "Code Action (Rust)" })
              vim.keymap.set( "n", "<leader>dr", "<cmd>RustDebuggables<cr>", { buffer = buffer, desc = "Run Debuggables (Rust)" })
            end
          end)
          local mason_registry = require("mason-registry")
          -- rust tools configuration for debugging support
          local codelldb = mason_registry.get_package("codelldb")
          local extension_path = codelldb:get_install_path() .. "/extension/"
          local codelldb_path = extension_path .. "adapter/codelldb"
          local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
            or extension_path .. "lldb/lib/liblldb.so"
          local user_rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
          local rust_tools_opts = vim.tbl_deep_extend("force", user_rust_tools_opts, {
            dap = {
              adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
            tools = {
              on_initialized = function()
                vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
              end,
            },
            server = vim.tbl_deep_extend("force", opts, {
              settings = {
                ["rust-analyzer"] = {
                  cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                  },
                  -- Add clippy lints for Rust.
                  checkOnSave = {
                    allFeatures = true,
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                  },
                  procMacro = {
                    enable = true,
                    ignored = {
                      ["async-trait"] = { "async_trait" },
                      ["napi-derive"] = { "napi" },
                      ["async-recursion"] = { "async_recursion" },
                    },
                  },
                },
              },
            }),
          })
          require("rust-tools").setup(rust_tools_opts)
          return true
        end,
        taplo = function(_, _)
          local function show_documentation()
            if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
              require("crates").show_popup()
            else
              vim.lsp.buf.hover()
            end
          end
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "taplo" then
              vim.keymap.set("n", "K", show_documentation, { buffer = buffer, desc = "Show Crate Documentation" })
            end
          end)
          return false -- make sure the base implementation calls taplo.setup
        end,
      },
    },
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
  },
}
