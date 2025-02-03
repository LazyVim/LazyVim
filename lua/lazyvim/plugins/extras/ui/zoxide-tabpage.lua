---action after zoxide dir selection
---@param path string
local function action(path)
  vim.cmd("tabnew")
  vim.cmd.tcd(path)
  vim.cmd("setl bufhidden=wipe")
  LazyVim.pick()()
end

return {
  -- tabpage rename with cmd name
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      -- custom tabpage naming pattern
      local function getCurrentCwdDirName()
        local cwd = vim.uv.cwd()
        if cwd == nil then
          vim.notify("Cwd is nil!", vim.log.levels.ERROR, nil)
          return "error"
        end
        return cwd:match("([^/\\]+)$")
      end

      -- auto-rename tab when enter
      vim.api.nvim_create_autocmd("TabNewEntered", {
        callback = function()
          -- Schedule the renaming after the tab is fully entered
          vim.schedule(function()
            vim.cmd("BufferLineTabRename " .. getCurrentCwdDirName())
          end)
        end,
      })

      local function renameAllTabs()
        local current_tab = vim.fn.tabpagenr()
        for tabnr = 1, vim.fn.tabpagenr("$") do
          vim.cmd(tabnr .. "tabnext") -- Switch to the tab with the number `tabnr`
          vim.cmd("BufferLineTabRename " .. getCurrentCwdDirName()) -- Rename the tab
          vim.cmd(current_tab .. "tabnext")
        end
      end

      -- hook into persistence.nvim to rename tabs after restoring a session
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceLoadPost",
        once = true,
        callback = function()
          vim.defer_fn(function()
            if vim.fn.exists(":BufferLineTabRename") == 2 then
              renameAllTabs()
            end
          end, 1000)
        end,
      })
      return opts
    end,
  },
  -- snacks picker integration
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      picker = {
        ---@type table<string, snacks.picker.Config|{}>
        sources = {
          zoxide = {
            confirm = function(picker, item)
              picker:close()
              if item then
                action(item.text)
              end
            end,
          },
        },
      },
    },
    keys = {
      {
        "<leader>sz",
        function()
          Snacks.picker.zoxide()
        end,
        desc = "Zoxide",
      },
    },
  },
  -- telescope integration
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = {
      "jvgrootveld/telescope-zoxide",
    },
    opts = {
      extensions = {
        zoxide = {
          mappings = {
            default = {
              action = function(selection)
                action(selection.path)
              end,
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>sz",
        [[<cmd>Telescope zoxide list theme=dropdown previewer=false<cr>]],
        desc = "Zoxide",
      },
    },
  },
}
