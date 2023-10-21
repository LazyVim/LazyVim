---@type string
local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

---@param path string
local function have(path)
  return vim.loop.fs_stat(xdg_config .. "/" .. path) ~= nil
end

return {

  -- Add Hyprland Parser
  {
    "luckasRanarison/tree-sitter-hypr",
    enabled = function()
      return have("hypr")
    end,
    event = "BufRead */hypr/*.conf",
    build = ":TSUpdate hypr",
    config = function()
      -- Fix ft detection for hyprland
      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hypr" },
      })
      require("nvim-treesitter.parsers").get_parser_configs().hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        filetype = "hypr",
      }
    end,
  },

  -- add some stuff to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local function add(lang)
        if type(opts.ensure_installed) == "table" then
          table.insert(opts.ensure_installed, lang)
        end
      end

      vim.filetype.add({
        extension = { rasi = "rasi" },
        pattern = {
          [".*/waybar/config"] = "jsonc",
          [".*/mako/config"] = "dosini",
          [".*/kitty/*.conf"] = "bash",
        },
      })

      add("git_config")

      if have("fish") then
        add("fish")
      end

      if have("rofi") or have("wofi") then
        add("rasi")
      end
    end,
  },
}
