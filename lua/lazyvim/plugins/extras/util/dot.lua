---@type string
local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

---@param path string
local function have(path)
  return vim.loop.fs_stat(xdg_config .. "/" .. path) ~= nil
end

return {

  -- Add Hyprland Parser
  {
    "luckasRanarison/tree-sitter-hyprlang",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        require("nvim-treesitter.parsers").get_parser_configs().hyprlang = {
          install_info = {
            url = "https://github.com/luckasRanarison/tree-sitter-hyprlang",
            files = { "src/parser.c" },
            branch = "master",
          },
          filetype = "hyprlang",
        }

        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "hyprlang" })
      end,
    },
    enabled = function()
      return have("hypr")
    end,
    event = "BufRead */hypr/*.conf",
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
