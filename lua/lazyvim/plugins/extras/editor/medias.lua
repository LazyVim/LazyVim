return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    dependencies = {
      {
        "nvim-telescope/telescope-media-files.nvim",
        enabled = function()
          if not vim.tbl_contains(LazyVim.config.json.data.extras, "lazyvim.plugins.extras.editor.medias") then
            return false
          end

          local function disableWithWarnMessage(msg)
            LazyVim.warn(
              "You have enabled extras.editor.medias, see (:`LazyExtras`). \n\n"
                .. msg
                .. "\n\nMore information can be found at: "
                .. "[nvim-telescope/telescope-media-files.nvim](https://github.com/nvim-telescope/telescope-media-files.nvim?tab=readme-ov-file#prerequisites)."
            )
            return false
          end

          if vim.fn.executable("chafa") == 0 then
            return disableWithWarnMessage("The required prerequisite not installed: `Chafa`")
          end

          local hasFindCmd = vim.tbl_contains({ "find", "fd", "rg" }, function(cmd)
            return vim.fn.executable(cmd) == 1
          end, { predicate = true })

          if not hasFindCmd then
            return disableWithWarnMessage(
              "None of the required 'find cmd' prerequisites is installed.\n"
                .. "Please install at least one of the following: `rd`, `rg`, or `find`."
            )
          end

          return true
        end,
        config = function()
          local findCmd = ""
          --- @class Set A simple Set implementation using a table to avoid duplicates; it only contains the methods add and toList
          --- @field _data table<string, 1>  Table to hold the set data.
          local supportedFiletypeSet = { _data = {} }

          function supportedFiletypeSet:add(values)
            values = type(values) == "string" and { values } or values

            for _, value in ipairs(values) do
              if not self._data[value] then
                self._data[value] = 1
              end
            end
          end

          function supportedFiletypeSet:toList()
            return vim.tbl_keys(self._data)
          end

          -- Find the installed 'find' command
          for _, cmd in ipairs({ "find", "fd", "rg" }) do
            if vim.fn.executable(cmd) == 1 then
              findCmd = cmd
              break
            end
          end

          -- Add the supported file types if the tool is installed
          local tools = {
            { cmd = "chafa", name = "Chafa", filetypes = { "png", "jpg", "jpeg", "webp" } },
            { cmd = "convert", name = "ImageMagick", filetypes = { "svg" } },
            { cmd = "ffmpegthumbnailer", name = "ffmpegthumbnailer", filetypes = { "mp4", "webm" } },
            { cmd = "pdftoppm", name = "pdftoppm", filetypes = { "pdf" } },
            { cmd = "epub-thumbnailer", name = "epub-thumbnailer", filetypes = { "epub" } },
            { cmd = "fontpreview", name = "fontpreview", filetypes = { "ttf", "otf" } },
          }
          for _, tool in ipairs(tools) do
            if vim.fn.executable(tool.cmd) == 1 then
              supportedFiletypeSet:add(tool.filetypes)
            end
          end

          -- Setup extension for media files when telescope is loaded
          LazyVim.on_load("telescope.nvim", function()
            local ok, telescope = pcall(require, "telescope")
            if ok then
              telescope.extensions["media_files"] = vim.tbl_extend("force", telescope.extensions["media_files"] or {}, {
                filetypes = supportedFiletypeSet:toList(),
                find_cmd = findCmd,
              })
            else
              LazyVim.error("Failed to load telescope.nvim")
            end
          end)
        end,
        keys = {
          { "<leader>fP", "<cmd>Telescope media_files<cr>", desc = "Find Media Files" },
        },
      },
    },
  },
}
