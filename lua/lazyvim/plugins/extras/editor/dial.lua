return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" } },
    { "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" } },
    -- there was some issue without remap = true
    { "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" }, remap = true },
    { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, remap = true },
  },
  opts = function()
    local augend = require("dial.augend")

    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })

    local ordinal_numbers = augend.constant.new({
      -- elements through which we cycle. When we increment, we go down
      -- On decrement we go up
      elements = {
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      },
      -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
      word = false,
      -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
      -- Otherwise nothing will happen when there are no further values
      cyclic = true,
    })

    local weekdays = augend.constant.new({
      elements = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      },
      word = true,
      cyclic = true,
    })

    local months = augend.constant.new({
      elements = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      },
      word = true,
      cyclic = true,
    })

    local capitalized_boolean = augend.constant.new({
      elements = {
        "True",
        "False",
      },
      word = true,
      cyclic = true,
    })

    return {
      groups_by_filetypes = {
        typescript = {
          "typescript",
          "typescriptreact",
          "javascript",
          "javascriptreact",
        },
        css = { "css", "scss", "sass" },
        markdown = { "markdown" },
        json = { "json" },
        lua = { "lua" },
        python = { "python" },
      },
      groups = {
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        },
        typescript = {
          augend.integer.alias.decimal, -- nonnegative and negative decimal number
          augend.constant.alias.bool, -- boolean value (true <-> false)
          logical_alias,
          augend.constant.new({ elements = { "let", "const" } }),
          ordinal_numbers,
          weekdays,
          months,
        },
        css = {
          augend.integer.alias.decimal, -- nonnegative and negative decimal number
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
        markdown = {
          augend.misc.alias.markdown_header,
          ordinal_numbers,
          weekdays,
          months,
        },
        json = {
          augend.integer.alias.decimal, -- nonnegative and negative decimal number
          augend.semver.alias.semver, -- versioning (v1.1.2)
        },
        lua = {
          augend.integer.alias.decimal, -- nonnegative and negative decimal number
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.constant.new({
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
          ordinal_numbers,
          weekdays,
          months,
        },
        python = {
          augend.integer.alias.decimal, -- nonnegative and negative decimal number
          capitalized_boolean,
          logical_alias,
          ordinal_numbers,
          weekdays,
          months,
        },
      },
    }
  end,
  config = function(_, opts)
    require("dial.config").augends:register_group(opts.groups)

    -- autocmd
    local set_dial_group = function(lang)
      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal(lang), {})
      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "v", "<C-a>", require("dial.map").inc_visual(lang), {})

      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "n", "<C-x>", require("dial.map").dec_normal(lang), {})
      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "v", "<C-x>", require("dial.map").dec_visual(lang), {})

      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "n", "g<C-a>", require("dial.map").inc_gnormal(lang), {})
      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "v", "g<C-a>", require("dial.map").inc_gvisual(lang), {})

      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "n", "g<C-x>", require("dial.map").dec_gnormal(lang), {})
      -- stylua: ignore
      vim.api.nvim_buf_set_keymap(0, "v", "g<C-x>", require("dial.map").dec_gvisual(lang), {})
    end

    local dial_augroup = vim.api.nvim_create_augroup("DialFileType", { clear = true })
    local is_current_buffer_has_group = false

    for lang, patterns in pairs(opts.groups_by_filetypes) do
      vim.api.nvim_create_autocmd("FileType", {
        group = dial_augroup,
        pattern = patterns,
        callback = function()
          set_dial_group(lang)
        end,
      })
      vim.notify(vim.inspect(opts.groups_by_filetypes))

      for _, pattern in ipairs(patterns) do
        vim.notify(pattern .. " in " .. vim.inspect(patterns) .. ". Current filetype: " .. vim.bo.filetype)
        if vim.bo.filetype == pattern then
          set_dial_group(lang)
          is_current_buffer_has_group = true
        end
      end
    end
    if not is_current_buffer_has_group then
      set_dial_group("default")
    end
  end,
}
