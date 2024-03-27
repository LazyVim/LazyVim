return {
  {
    "lewis6991/gitsigns.nvim",
    optional = true,
    opts = {
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "󱈸" },
        topdelete = { text = "󱈸" },
        changedelete = { text = "┃" },
        untracked = { text = "┇" },
      },
      signcolumn = true,
      numhl = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
    end,
  },
  { -- better statuscolumn
    "luukvbaal/statuscol.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        ft_ignore = { "neo-tree", "neo-tree-popup", "alpha", "lazy", "mason" },
        segments = {
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          {
            sign = { name = { "Diagnostic*" }, text = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
            click = "v:lua.ScSa",
          },
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        },
      }
    end,
    init = function() end,
    config = function(_, opts)
      require("statuscol").setup(opts)
    end,
  },
  { -- better fold
    "kevinhwang91/nvim-ufo",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" ... 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      return {
        fold_virt_text_handler = handler,
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        open_fold_hl_timeout = 400,
        close_fold_kinds = { "imports", "comment" },
        preview = {
          win_config = { border = { "", "─", "", "", "", "─", "", "" }, winblend = 0 },
          mappings = {
            scrollU = "<C-b>",
            scrollD = "<C-f>",
            jumpTop = "[",
            jumpBot = "]",
          },
        },
      }
    end,
    config = function(_, opts)
      require("ufo").setup(opts)

      local map = require("lazyvim.util").safe_keymap_set
      map("n", "K", function()
        if not require("ufo").peekFoldedLinesUnderCursor() then
          vim.lsp.buf.hover()
        end
      end, { desc = "Peek folded lines under cursor or hover" })
    end,
  },
}
