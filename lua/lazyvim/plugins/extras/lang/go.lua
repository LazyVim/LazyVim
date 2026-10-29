-- `gohtml` is the html/template dialect of `gotmpl`: the same grammar, but with
-- html injected into the text between actions. It mirrors how `helm` injects
-- yaml into that grammar, and is kept separate for the same reason — `gotmpl`
-- is also used for text/template (configs, emails, manifests), where injecting
-- html would be wrong.
-- Registered here rather than in `on_very_lazy`: a file named on the command
-- line is detected before VeryLazy fires, and would open without a filetype.
vim.filetype.add({
  extension = { gohtml = "gohtml" },
  pattern = { [".*%.html%.tmpl"] = "gohtml" },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gohtml",
  group = vim.api.nvim_create_augroup("lazyvim_gohtml", { clear = true }),
  callback = function(ev)
    -- Alias the installed `gotmpl` parser under the `gohtml` language rather
    -- than shipping a second copy of the same grammar: the queries differ, the
    -- parser does not. Registering the language is also what makes
    -- `queries/gohtml/` apply instead of `gotmpl`'s own.
    if #vim.api.nvim_get_runtime_file("parser/gohtml.so", false) == 0 then
      local gotmpl = vim.api.nvim_get_runtime_file("parser/gotmpl.so", false)[1]
      if not gotmpl then
        return
      end
      if not pcall(vim.treesitter.language.add, "gohtml", { path = gotmpl, symbol_name = "gotmpl" }) then
        return
      end
    end
    -- Started here rather than by the treesitter extra, which only starts
    -- languages nvim-treesitter reports as installed; `gohtml` never is.
    pcall(vim.treesitter.start, ev.buf)
  end,
})

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "go", "gomod", "gowork", "gotmpl", "gohtml" },
      root = { "go.work", "go.mod" },
    })
  end,
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gowork", "gosum", "gotmpl" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          init_options = {
            semanticTokens = true,
          },
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            },
          },
        },
      },
      setup = {
        -- html-lsp gives gohtml files tag and attribute completion. Extended
        -- through `setup`, which only runs for servers something else has
        -- already enabled: pulling in an npm language server for everyone
        -- writing Go would be too much for what it adds.
        html = function(_, opts)
          opts.filetypes = opts.filetypes or { "html" }
          if not vim.tbl_contains(opts.filetypes, "gohtml") then
            table.insert(opts.filetypes, "gohtml")
          end
        end,
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
            if
              client.config
              and client.config.init_options
              and client.config.init_options.semanticTokens
              and not client.server_capabilities.semanticTokensProvider
            then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end)
          -- end workaround
        end,
      },
    },
  },
  -- Ensure Go tools are installed
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "goimports", "gofumpt" } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "gomodifytags", "impl" } },
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.code_actions.impl,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.gofumpt,
      })
    end,
  },
  -- Add linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "golangci-lint" } },
      },
    },
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        -- No formatter round-trips Go template actions safely, html-lsp least
        -- of all — it reflows the markup around {{ }} it cannot parse. Without
        -- this, `default_format_opts.lsp_format = "fallback"` hands these
        -- buffers to html-lsp as soon as it is attached, because no formatter
        -- is configured for them.
        gohtml = { lsp_format = "never" },
        gotmpl = { lsp_format = "never" },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "delve" } },
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          -- Here we can set options for neotest-golang, e.g.
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
      },
    },
  },

  -- Filetype icons
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
        gohtml = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },
}
