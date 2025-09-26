---@diagnostic disable: missing-fields
if lazyvim_docs then
  -- Set to `false` (recommended, requires neovim >= 0.12) in your `options.lua` to enable native inline completions
  vim.g.ai_cmp = true

  -- Set to `true` in your `options.lua` to enable experimental support for Next Edit Suggestions
  vim.g.copilot_nes = false
end

if LazyVim.has_extra("ai.copilot") then
  LazyVim.error("Please disable the `ai.copilot` extra if you want to use `ai.copilot-native`")
  return {}
end

local has_blink = LazyVim.has_extra("coding.blink")
if not (vim.lsp.inline_completion or has_blink) then
  LazyVim.error("You need Neovim >= 0.12 or `coding.blink` extra to use the `ai.copilot-native` extra.")
  return {}
end
-- nvim-cmp doesn't supports the copilot lsp source, only blink does
if not has_blink then
  vim.g.ai_cmp = false -- nvim-cmp + native inline completion
elseif not vim.lsp.inline_completion then
  vim.g.ai_cmp = true -- blink + blink-copilot
end

local status = {} ---@type table<number, "ok" | "error" | "pending">

return {
  desc = "Native Copilot LSP integration. Requires Neovim >= 0.12 or coding.blink extra",
  -- copilot-language-server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        copilot = {
          handlers = {
            didChangeStatus = function(err, res, ctx)
              if err then
                return
              end
              status[ctx.client_id] = res.kind ~= "Normal" and "error" or res.busy and "pending" or "ok"
              if res.status == "Error" then
                LazyVim.error("Please use `:LspCopilotSignIn` to sign in to Copilot")
              end
            end,
          },
          -- stylua: ignore
          keys = vim.g.ai_cmp and {} or {
            {
              "<M-]>",
              function() vim.lsp.inline_completion.select({ count = 1 }) end,
              desc = "Next Copilot Suggestion",
              mode = { "i", "n" },
            },
            {
              "<M-[>",
              function() vim.lsp.inline_completion.select({ count = -1 }) end,
              desc = "Next Copilot Suggestion",
              mode = { "i", "n" },
            },
          },
        },
      },
      setup = {
        copilot = function()
          if not vim.g.ai_cmp then
            vim.lsp.inline_completion.enable()
          end

          -- Only trigger NES updates:
          -- * when leaving insert mode
          -- * when text is changed (in normal mode)
          -- * when accepting a next edit suggestion
          local nes_update = Snacks.util.debounce(function()
            return vim.g.copilot_nes and require("copilot-lsp.nes").request_nes("copilot")
          end, { ms = 100 })

          vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
            group = vim.api.nvim_create_augroup("lazyvim.copilot-native.complete", { clear = true }),
            callback = nes_update,
          })

          -- Accept inline suggestions or next edits
          LazyVim.cmp.actions.ai_accept = function()
            if vim.b.nes_state then
              local nes = require("copilot-lsp.nes")

              -- Try to jump to the start of the suggestion edit.
              if nes.walk_cursor_start_edit() then
                return true
              end

              -- apply the pending suggestion and jump to the end of the edit.
              if nes.apply_pending_nes() then
                nes.walk_cursor_end_edit()
                nes_update() -- trigger new nes update after accept
                return true
              end
            end
            if not vim.g.ai_cmp and vim.lsp.inline_completion.get() then
              -- nes_update() -- ensure nes update is triggered after inline completion
              return true
            end
          end
        end,
      },
    },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_x,
        2,
        LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
          local clients = vim.lsp.get_clients({ name = "copilot", bufnr = 0 })
          return #clients > 0 and status[clients[1].id] or nil
        end)
      )
    end,
  },

  vim.g.ai_cmp and {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  } or { import = "foobar", enabled = false }, -- dummy import

  vim.g.copilot_nes
      and {
        "copilotlsp-nvim/copilot-lsp",
        init = function()
          vim.api.nvim_create_autocmd("BufEnter", {
            callback = function(ev)
              local buf = ev.buf
              local client = vim.lsp.get_clients({ name = "copilot", bufnr = buf })[1]
              if not client then
                return
              end
              client:notify("textDocument/didFocus", {
                textDocument = {
                  uri = vim.uri_from_bufnr(buf),
                },
              })
            end,
          })

          LazyVim.cmp.actions.ai_stop = function()
            require("copilot-lsp.nes").clear()
          end
        end,
        keys = {
          -- nes is also useful in normal mode
          { "<tab>", LazyVim.cmp.map({ "ai_accept" }, "<tab>"), mode = { "n" }, expr = true },
        },
      }
    or nil,
}
