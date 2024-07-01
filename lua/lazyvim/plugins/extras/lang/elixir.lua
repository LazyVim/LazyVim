return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "elixir", "eelixir", "heex", "surface" },
      root = "mix.exs",
    })
  end,
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {
          keys = {
            { "<leader>cp", ":ElixirToPipe<CR>", desc = "To Pipe" },
            { "<leader>cP", ":ElixirFromPipe<CR>", desc = "From Pipe" },
            { "<leader>ce", mode = { "v" }, ":ElixirExpandMacro<CR>", desc = "Expand Macro" },
          },
          on_attach = function(client, bufnr)
            local manipulate_pipes = function(direction)
              local get_cursor_position = function()
                local rowcol = vim.api.nvim_win_get_cursor(0)
                local row = rowcol[1] - 1
                local col = rowcol[2]
                return row, col
              end

              local row, col = get_cursor_position()
              client.request_sync("workspace/executeCommand", {
                command = "manipulatePipes:serverid",
                arguments = { direction, "file://" .. vim.api.nvim_buf_get_name(0), row, col },
              }, nil, 0)
            end

            vim.api.nvim_buf_create_user_command(bufnr, "ElixirFromPipe", function()
              manipulate_pipes("fromPipe")
            end, {})
            vim.api.nvim_buf_create_user_command(bufnr, "ElixirToPipe", function()
              manipulate_pipes("toPipe")
            end, {})

            vim.api.nvim_buf_create_user_command(bufnr, "ElixirExpandMacro", function()
              local params = vim.lsp.util.make_given_range_params()

              local text = vim.api.nvim_buf_get_text(
                0,
                params.range.start.line,
                params.range.start.character,
                params.range["end"].line,
                params.range["end"].character,
                {}
              )

              local resp = client.request_sync("workspace/executeCommand", {
                command = "expandMacro:serverid",
                arguments = { params.textDocument.uri, vim.fn.join(text, "\n"), params.range.start.line },
              }, nil, 0)

              local content = {}
              if resp["result"] then
                for k, v in pairs(resp.result) do
                  vim.list_extend(content, { "# " .. k, "" })
                  vim.list_extend(content, vim.split(v, "\n"))
                end
              else
                table.insert(content, "Error")
              end

              vim.schedule(function()
                local bufnr_floating, _ = vim.lsp.util.open_floating_preview(
                  vim.lsp.util.trim_empty_lines(content),
                  "elixir",
                  { border = "single" }
                )
                vim.api.nvim_buf_set_option(bufnr_floating, "filetype", "elixir")
              end)
            end, { range = true })
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "elixir", "heex", "eex" } },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "jfpedroza/neotest-elixir",
    },
    opts = {
      adapters = {
        ["neotest-elixir"] = {},
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.credo.with({
          condition = function(utils)
            return utils.root_has_file(".credo.exs")
          end,
        }),
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = {
        elixir = { "credo" },
      }

      opts.linters = {
        credo = {
          condition = function(ctx)
            return vim.fs.find({ ".credo.exs" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      }
    end,
  },
}
