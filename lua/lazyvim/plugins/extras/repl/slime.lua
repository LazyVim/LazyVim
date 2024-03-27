return {
  -- General vim repl code send
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_no_mappings = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_target = "neovim"
      vim.g.slime_menu_config = true
      vim.api.nvim_create_user_command("SlimeTarget", function(opts)
        if opts.args ~= nil then
          vim.b.slime_target = opts.args
          vim.b.slime_config = nil
        else
          vim.b.slime_config = vim.g.slime_config
          vim.b.slime_target = vim.g.slime_target
        end
        vim.notify("Slime send target is: " .. vim.b.slime_target)
      end, { desc = "Change Slime target", nargs = 1 })
    end,
    cmd = { "SlimeConfig", "SlimeTarget" },
    keys = {
      { "<S-CR>", "<Plug>SlimeRegionSend", mode = "x", desc = "Send Selection" },
      { "<S-CR>", "<Plug>SlimeMotionSend", mode = "n", desc = "Send Textobject" },
      { "<leader>rr", "<Plug>SlimeMotionSend", mode = "n", desc = "Send Textobject (<S-CR>)" },
      { "<S-CR><S-CR>", "<S-CR>ir]rj", mode = "n", remap = true, desc = "Send Cell and Jump Next" },
      { "<leader>rC", "<Cmd>SlimeConfig<CR>", desc = "Slime Run Config" },
      { "<leader>rT", "<Cmd>SlimeTarget<CR>", desc = "Slime Run Target" },
    },
  },
  -- Separator overlay on cell marker & metadata
  {
    "echasnovski/mini.hipatterns",
    optional = true,
    opts = function(_, opts)
      local censor_extmark_opts = function(buf_id, match, data)
        local mask = string.rep("⎯", vim.api.nvim_win_get_width(0))
        return {
          virt_text = { { mask, "SignColumn" } },
          virt_text_pos = "overlay",
          virt_text_hide = true,
          priority = 200,
          right_gravity = false,
        }
      end
      opts.highlighters["cell_marker"] = {
        pattern = function(bufid)
          local cmt_str = vim.api.nvim_get_option_value("commentstring", { buf = bufid })
          return "^" .. string.gsub(cmt_str, [[%s]], "") .. [[*%%.*]]
        end,
        group = "",
        extmark_opts = censor_extmark_opts,
      }
    end,
  },
  -- Define code cell object `ir`, `ar`
  {
    "echasnovski/mini.ai",
    opts = {
      custom_textobjects = {
        r = function(ai_mode, _, _)
          local buf_nlines = vim.api.nvim_buf_line_count(0)
          local cell_markers = {}
          for line_no = 1, buf_nlines do
            local line = vim.fn.getline(line_no)
            if line:match("^# *%%%%") then
              table.insert(cell_markers, line_no)
            end
          end
          table.insert(cell_markers, 1, 0) -- Beginning
          table.insert(cell_markers, #cell_markers + 1, buf_nlines + 1)

          local regions = {}
          for i = 1, #cell_markers - 1 do
            local from_line, to_line
            if ai_mode == "i" then
              from_line = cell_markers[i] + 1
              to_line = cell_markers[i + 1] - 1
            else
              from_line = math.max(cell_markers[i], 1)
              to_line = cell_markers[i + 1] - 1
            end
            -- for `around cell` on empty line select previous cell
            local to_line_len = vim.fn.getline(to_line):len() + 1
            table.insert(regions, {
              from = { line = from_line, col = 1 },
              to = { line = to_line, col = to_line_len },
            })
          end
          return regions
        end,
      },
    },
  },
  -- Mapping for moving between cell `]r`, `[r`
  -- defined in query/python/textobjects.scm
  {
    "nvim-treesitter",
    opts = {
      textobjects = {
        move = {
          goto_next_start = { ["]r"] = "@cell.marker" },
          goto_previous_start = { ["[r"] = "@cell.marker" },
        },
      },
    },
  },
  {
    "lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, {
        function()
          -- show terminal jobid if in a Slime connected buffer
          if vim.b.slime_config and vim.b.slime_config.jobid then
            return " " .. vim.b.slime_config.jobid
          -- or if cursor focus on a terminal buffer
          elseif vim.o.buftype == "terminal" then
            return " " .. vim.o.channel
          else
            return ""
          end
        end,
        color = LazyVim.ui.fg("Constant"),
      })
    end,
  },
}
