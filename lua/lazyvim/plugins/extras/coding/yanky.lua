-- better yank/paste
return {
  "gbprod/yanky.nvim",
  recommended = true,
  desc = "Better Yank/Paste",
  event = "LazyFile",
  opts = {
    highlight = { timer = 150 },
  },
  keys = {
    {
      "<leader>p",
      function()
        if LazyVim.pick.picker.name == "telescope" then
          require("telescope").extensions.yank_history.yank_history({})
        elseif LazyVim.pick.picker.name == "fzf" then
          local fzf = require("fzf-lua")
          local histories = require("yanky.history").all()

          local make_display = function(k, v)
            return fzf.utils.ansi_codes.yellow(tostring(k))
              .. " "
              .. v.regcontents:gsub("\n", fzf.utils.ansi_codes.grey("\\n"))
          end

          local get_content = function(content_str)
            local index = string.match(content_str, "^%d+")
            return histories[tonumber(index)]
          end
          local entries = {}
          for k, v in ipairs(histories) do
            table.insert(entries, make_display(k, v))
          end

          -- previewer  https://github.com/ibhagwan/fzf-lua/wiki/Advanced#neovim-builtin-preview
          local builtin = require("fzf-lua.previewer.builtin")

          local TmpBufferPreviewer = builtin.base:extend()
          function TmpBufferPreviewer:new(o, opts, fzf_win)
            TmpBufferPreviewer.super.new(self, o, opts, fzf_win)
            setmetatable(self, TmpBufferPreviewer)
            return self
          end

          function TmpBufferPreviewer:populate_preview_buf(entry_str)
            local content = get_content(entry_str)

            local tmpbuf = self:get_tmp_buffer()

            vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, true, vim.split(content.regcontents, "\n"))
            if content.filetype ~= nil then
              vim.bo[tmpbuf].filetype = content.filetype
            end

            self:set_preview_buf(tmpbuf)
            self.win:update_scrollbar()
          end

          -- Disable line numbering and word wrap
          function TmpBufferPreviewer:gen_winopts()
            local new_winopts = {
              wrap = false,
              number = false,
            }
            return vim.tbl_extend("force", self.winopts, new_winopts)
          end

          local opts = {
            fzf_opts = {
              ["--preview"] = function(items)
                return get_content(items[1]).regcontents
              end,
            },
            previewer = TmpBufferPreviewer,
            fzf_colors = true,
            actions = {
              ["default"] = function(items)
                require("yanky.picker").actions.put("p")(get_content(items[1]))
              end,
            },
          }
          fzf.fzf_exec(entries, opts)
        else
          vim.cmd([[YankyRingHistory]])
        end
      end,
      desc = "Open Yank History",
    },
        -- stylua: ignore
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Yanked Text Before Cursor" },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Selection" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Yanked Text Before Selection" },
    { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
    { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
    { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
    { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
    { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
    { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
    { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
    { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
    { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
    { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
  },
}
