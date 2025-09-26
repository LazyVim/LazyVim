---@diagnostic disable: missing-fields
if lazyvim_docs then
  -- Native inline completions don't support being shown as regular completions
  vim.g.ai_cmp = false
end

if LazyVim.has_extra("ai.copilot-native") then
  if not vim.lsp.inline_completion then
    LazyVim.error("You need Neovim >= 0.12 to use the `ai.copilot-native` extra.")
    return {}
  end
  if LazyVim.has_extra("ai.copilot") then
    LazyVim.error("Please disable the `ai.copilot` extra if you want to use `ai.copilot-native`")
    return {}
  end
end

vim.g.ai_cmp = false

return {
  desc = "Native Copilot LSP integration. Requires Neovim >= 0.12",
  -- copilot-language-server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        copilot = {
          -- stylua: ignore
          keys = {
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
          vim.lsp.inline_completion.enable()

          -- Accept inline suggestions or next edits
          LazyVim.cmp.actions.ai_accept = function()
            local Nes = require("copilot.nes")
            if Nes.have() and (Nes.jump() or Nes.apply()) then
              return true
            end

            if vim.lsp.inline_completion.get() then
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
          local status = require("copilot.status").get()
          if status then
            return status.kind == "Error" and "error" or status.busy and "pending" or "ok"
          end
        end)
      )
    end,
  },

  {
    "folke/copilot.nvim",
    init = function()
      LazyVim.cmp.actions.ai_stop = function()
        require("copilot").hide()
      end
    end,
    opts = {},
    keys = {
      -- nes is also useful in normal mode
      { "<tab>", LazyVim.cmp.map({ "ai_accept" }, "<tab>"), mode = { "n" }, expr = true },
    },
  } or nil,
}
