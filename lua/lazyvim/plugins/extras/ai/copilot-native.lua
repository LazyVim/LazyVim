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
        copilot = {},
      },
      setup = {
        copilot = function(_, opts)
          vim.lsp.inline_completion.enable()
          LazyVim.cmp.actions.ai_accept = function()
            return vim.lsp.inline_completion.get()
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
      table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.lsp("copilot"))
    end,
  },
}
