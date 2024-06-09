return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-media-files.nvim",
        config = function(_, opts)
          if not LazyVim.has("telescope.nvim") then
            return
          end

          -- https://github.com/nvim-telescope/telescope-media-files.nvim?tab=readme-ov-file#prerequisites
          local prerequisites = {
            required = {
              { cmd = "chafa", name = "Chafa", filetypes = { "png", "jpg", "jpeg", "webp", "svg" } },
            },
            findCmd = {
              { cmd = "fd", name = "fd" },
              { cmd = "rg", name = "rg" },
              { cmd = "find", name = "find" },
            },
            optional = {
              { cmd = "convert", name = "ImageMagick", filetypes = {} },
              { cmd = "ffmpegthumbnailer", name = "ffmpegthumbnailer", filetypes = { "mp4", "webm" } },
              { cmd = "pdftoppm", name = "pdftoppm", filetypes = { "pdf" } },
              { cmd = "epub-thumbnailer", name = "epub-thumbnailer", filetypes = { "epub" } },
              { cmd = "fontpreview", name = "fontpreview", filetypes = { "ttf", "otf" } },
            },
          }
          local function sendPrerequisitesError(msg)
            LazyVim.error(
              msg
                .. "\nMore information can be found at: "
                .. "https://github.com/nvim-telescope/telescope-media-files.nvim?tab=readme-ov-file#prerequisites"
            )
          end

          local filetypes = {}

          -- Ensure all required prerequisites are installed
          for _, tool in ipairs(prerequisites.required) do
            if vim.fn.executable(tool.cmd) == 0 then
              sendPrerequisitesError("Required prerequisite not installed: " .. tool.name)
              return
            else
              filetypes = vim.tbl_extend("force", filetypes, tool.filetypes)
            end
          end

          -- Verify that at least one of the required find commands is installed
          local findCmd = ""
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
            return
          end

          -- Check optional prerequisites and include their filetypes if installed
          for _, tool in ipairs(prerequisites.optional) do
            if vim.fn.executable(tool.cmd) == 1 then
              filetypes = vim.tbl_extend("force", filetypes, tool.filetypes)
            end
          end

          -- Setup media_files extension for telescope
          LazyVim.on_load("telescope.nvim", function()
            local ok, err = pcall(require("telescope").load_extension, "media_files")
            if ok then
              opts.extensions = vim.tbl_extend("force", opts.extensions or {}, {
                media_files = { filetypes = filetypes, find_cmd = findCmd },
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
