local findCmd = ""
-- Use the simple Set that implemented by a table to avoid duplicates; it only contains the methods add and toList
local supportedFiletypeSet = { _data = {} }

function supportedFiletypeSet:add(values)
  if type(values) == "string" then
    values = { values }
  end

  for _, value in ipairs(values) do
    if not self._data[value] then
      self._data[value] = 1
    end
  end
end

function supportedFiletypeSet:toList()
  return vim.tbl_keys(self._data)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-media-files.nvim",
        event = "VeryLazy",
        enabled = function()
          if not LazyVim.has("telescope.nvim") then
            return false
          end

          local function sendPrerequisitesError(msg)
            LazyVim.warn(
              "You have enabled extras.editor.medias, see (:`LazyExtras`). \n\n"
                .. msg
                .. "\n\nMore information can be found at: "
                .. "[nvim-telescope/telescope-media-files.nvim](https://github.com/nvim-telescope/telescope-media-files.nvim?tab=readme-ov-file#prerequisites)."
            )
          end
          local prerequisites = {
            required = {
              { cmd = "chafa", name = "Chafa", filetypes = { "png", "jpg", "jpeg", "webp" } },
            },
            findCmd = {
              { cmd = "fd", name = "fd" },
              { cmd = "rg", name = "rg" },
              { cmd = "find", name = "find" },
            },
            optional = {
              { cmd = "convert", name = "ImageMagick", filetypes = { "svg" } },
              { cmd = "ffmpegthumbnailer", name = "ffmpegthumbnailer", filetypes = { "mp4", "webm" } },
              { cmd = "pdftoppm", name = "pdftoppm", filetypes = { "pdf" } },
              { cmd = "epub-thumbnailer", name = "epub-thumbnailer", filetypes = { "epub" } },
              { cmd = "fontpreview", name = "fontpreview", filetypes = { "ttf", "otf" } },
            },
          }

          -- Ensure all required prerequisites are installed
          for _, tool in ipairs(prerequisites.required) do
            if vim.fn.executable(tool.cmd) == 0 then
              sendPrerequisitesError(string.format("The required prerequisite not installed: `%s`", tool.name))
              return false
            else
              supportedFiletypeSet:add(tool.filetypes)
            end
          end

          -- Verify that at least one of the required find commands is installed
          for _, tool in ipairs(prerequisites.findCmd) do
            if vim.fn.executable(tool.cmd) == 1 then
              findCmd = tool.cmd
              break
            end
          end

          if not findCmd then
            sendPrerequisitesError(
              "None of the required 'find cmd' prerequisites is installed.\n"
                .. "Please install at least one of the following: `rd`, `rg`, or `find`."
            )
            return false
          end

          -- Check optional prerequisites and include their filetypes if installed
          for _, tool in ipairs(prerequisites.optional) do
            if vim.fn.executable(tool.cmd) == 1 then
              supportedFiletypeSet:add(tool.filetypes)
            end
          end

          return true
        end,
        config = function(_, opts)
          LazyVim.on_load("telescope.nvim", function()
            local ok, err = pcall(require("telescope").load_extension, "media_files")
            if ok then
              opts.extensions = vim.tbl_extend("force", opts.extensions or {}, {
                media_files = { filetypes = supportedFiletypeSet:toList(), find_cmd = findCmd },
              })
            else
              LazyVim.error("Failed to load the telescope extension for `telescope-media-files.nvim`:\n" .. err)
            end
          end)
        end,
        keys = {
          { "<leader>fm", "<cmd>Telescope media_files<cr>", desc = "Find Media Files" },
        },
      },
    },
  },
}
