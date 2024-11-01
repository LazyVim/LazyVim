local k = require("lazyvim.keymaps").get_keymaps()

local pick = function()
  if LazyVim.pick.picker.name == "telescope" then
    return require("telescope").extensions.refactoring.refactors()
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local results = require("refactoring").get_refactors()
    local refactoring = require("refactoring")

    local opts = {
      fzf_opts = {},
      fzf_colors = true,
      actions = {
        ["default"] = function(selected)
          refactoring.refactor(selected[1])
        end,
      },
    }
    fzf_lua.fzf_exec(results, opts)
  end
end

return {
  {
    "ThePrimeagen/refactoring.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { k.refactoring_prefix, "", desc = "+refactor", mode = { "n", "v" } },
      {
        k.refactoring_refactor,
        pick,
        mode = "v",
        desc = "Refactor",
      },
      {
        k.refactoring_inline_variable,
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "v" },
        desc = "Inline Variable",
      },
      {
        k.refactoring_extract_block,
        function()
          require("refactoring").refactor("Extract Block")
        end,
        desc = "Extract Block",
      },
      {
        k.refactoring_extract_block_to_file,
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        desc = "Extract Block To File",
      },
      {
        k.refactoring_debug_print,
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        desc = "Debug Print",
      },
      {
        k.refactoring_debug_print_variable,
        function()
          require("refactoring").debug.print_var({ normal = true })
        end,
        desc = "Debug Print Variable",
      },
      {
        k.refactoring_debug_cleanup,
        function()
          require("refactoring").debug.cleanup({})
        end,
        desc = "Debug Cleanup",
      },
      {
        k.refactoring_extract_function,
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "v",
        desc = "Extract Function",
      },
      {
        k.refactoring_extract_function_to_file,
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        mode = "v",
        desc = "Extract Function To File",
      },
      {
        k.refactoring_extract_variable,
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "v",
        desc = "Extract Variable",
      },
      {
        k.refactoring_debug_print_variable,
        function()
          require("refactoring").debug.print_var()
        end,
        mode = "v",
        desc = "Debug Print Variable",
      },
    },
    opts = {
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true, -- shows a message with information about the refactor on success
      -- i.e. [Refactor] Inlined 3 variable occurrences
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      if LazyVim.has("telescope.nvim") then
        LazyVim.on_load("telescope.nvim", function()
          require("telescope").load_extension("refactoring")
        end)
      end
    end,
  },
}
