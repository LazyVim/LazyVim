local M = {}

---@class LazyVimKeymaps
local keymaps = nil

---@class LazyVimKeymaps
M.default_keymaps = {
  keymaps = {
    window = {
      left = "<C-h>",
      lower = "<C-j>",
      upper = "<C-k>",
      right = "<C-l>",
    },
    resize_window = {
      increase_height = "<C-Up>",
      decrease_height = "<C-Down>",
      decrease_width = "<C-Left>",
      increase_width = "<C-Right>",
    },
    move_lines = {
      down = "<A-j>",
      up = "<A-k>",
    },
    buffers = {
      prev = "<S-h>",
      next = "<S-l>",
      prev_alt = "[b",
      next_alt = "]b",
      switch_to_other = "<leader>bb",
      switch_to_other_alt = "<leader>`",
      delete = "<leader>bd",
      delete_and_close = "<leader>bD",
    },
    clear_search_diff_update_and_redraw = "<leader>ur",
    save_file = "<C-s>",
    keywordprg = "<leader>K",
    commenting = {
      add_comment_below = "gco",
      add_comment_above = "gcO",
    },
    lazy = "<leader>l",
    new_file = "<leader>fn",
    location_list = "<leader>xl",
    quickfix_list = "<leader>xq",
    previous_quickfix = "[q",
    next_quickfix = "]q",
    format = "<leader>cf",
    diagnostics = {
      line_diagnostics = "<leader>cd",
      next_diagnostic = "]d",
      prev_diagnostic = "[d",
      next_error = "]e",
      prev_error = "[e",
      next_warning = "]w",
      prev_warning = "[w",
    },
    toggle_options = {
      auto_format_buffer = "<leader>uf",
      auto_format_global = "<leader>uF",
      spelling = "<leader>us",
      wrap = "<leader>uw",
      relativenumber = "<leader>uL",
      diagnostics = "<leader>ud",
      number = "<leader>ul",
      conceallevel = "<leader>uc",
      treesitter = "<leader>uT",
      background = "<leader>ub",
      inlay_hints = "<leader>uh",
    },
    lazygit = {
      toggle_root = "<leader>gg",
      toggle_cwd = "<leader>gG",
      blame_line = "<leader>gb",
      browse = "<leader>gB",
      current_file_history = "<leader>gf",
      git_log_root = "<leader>gl",
      git_log_cwd = "<leader>gL",
    },
    quit_all = "<leader>qq",
    inspect_pos = "<leader>ui",
    inspect_tree = "<leader>uI",
    lazyvim_changelog = "<leader>L",
    terminal = {
      floating_terminal = {
        toggle_root = "<leader>ft",
        toggle_cwd = "<leader>fT",
        toggle_root_alt_1 = "<c-/>",
        toggle_root_alt_2 = "<c-_>",
      },
      enter_normal_mode = "<esc><esc>",
      hide_terminal = "<C-/>",
      hide_terminal_alt = "<c-_>",
    },
    windows = {
      windows = "<leader>w",
      split_window_below = "<leader>-",
      split_window_right = "<leader>|",
      delete_window = "<leader>wd",
      toggle_maximize_window = "<leader>wm",
    },
    tabs = {
      last_tab = "<leader><tab>l",
      close_other_tabs = "<leader><tab>o",
      first_tab = "<leader><tab>f",
      new_tab = "<leader><tab><tab>",
      next_tab = "<leader><tab>]",
      close_tab = "<leader><tab>d",
      previous_tab = "<leader><tab>[",
    },
  },
  quit_buffer = "q",
  coding = {
    cmp = {
      scroll_docs_backward = "<C-b>",
      scroll_docs_forward = "<C-f>",
      select_next_item = "<C-n>",
      select_prev_item = "<C-p>",
      complete = "<C-Space>",
      confirm_auto_select = "<CR>",
      confirm_select = "<C-y>",
      confirm_replace = "<S-CR>",
      abort = "<C-CR>",
      snippet = {
        jump_prev = "<Tab>",
        jump_next = "<S-Tab>",
      },
    },
  },
  editor = {
    neo_tree = {
      toggle_root = "<leader>fe",
      toggle_cwd = "<leader>fE",
      toggle_root_alt = "<leader>e",
      toggle_cwd_alt = "<leader>E",
      toggle_git_status = "<leader>ge",
      toggle_buffers = "<leader>be",
      window = {
        open = "l",
        close_node = "h",
        copy_path_to_clipboard = "Y",
        open_with_system_application = "O",
        toggle_preview = "P",
      },
    },
    grug_far = {
      open = "<leader>sr",
    },
    flash = {
      jump = "s",
      treesitter = "S",
      remote = "r",
      treesitter_search = "R",
      toggle = "<c-s>",
    },
    which_key = {
      group = {
        tabs = "<leader><tab>",
        code = "<leader>c",
        file_find = "<leader>f",
        git = "<leader>g",
        hunks = "<leader>gh",
        quit_session = "<leader>q",
        search = "<leader>s",
        ui = "<leader>u",
        diagnostics_quickfix = "<leader>x",
        buffer = "<leader>b",
        windows = "<leader>w",
      },
      buffer_keymaps = "<leader>?",
      window_hydra_mode = "<c-w><space>",
    },
    gitsigns = {
      next_hunk = "]h",
      prev_hunk = "[h",
      last_hunk = "]H",
      first_hunk = "[H",
      stage_hunk = "<leader>ghs",
      reset_hunk = "<leader>ghr",
      stage_buffer = "<leader>ghS",
      undo_stage_hunk = "<leader>ghu",
      reset_buffer = "<leader>ghR",
      preview_hunk_inline = "<leader>ghp",
      blame_line = "<leader>ghb",
      blame_buffer = "<leader>ghB",
      diff_index = "<leader>ghd",
      diff_commit = "<leader>ghD",
      select_hunk = "ih",
    },
    trouble = {
      diagnostics_toggle = "<leader>xx",
      diagnostics_buffer_toggle = "<leader>xX",
      symbols_toggle = "<leader>cs",
      lsp_toggle = "<leader>cS",
      loclist_toggle = "<leader>xL",
      qflist_toggle = "<leader>xQ",
      previous_trouble = "[q",
      next_trouble = "]q",
    },
    todo_comments = {
      next_todo = "]t",
      prev_todo = "[t",
      todo_trouble = "<leader>xt",
      todo_fix_fixme_trouble = "<leader>xT",
      todo_telescope = "<leader>st",
      todo_fix_fixme_telescope = "<leader>sT",
    },
  },
  formatting = {
    conform = {
      format = "<leader>cF",
    },
  },
  treesitter = {
    increment_selection = "<C-Space>",
    decrement_selection = "<BS>",
    textobjects = {
      goto_next_start = {
        function_outer = "]f",
        class_outer = "]c",
        parameter_inner = "]a",
      },
      goto_next_end = {
        function_outer = "]F",
        class_outer = "]C",
        parameter_inner = "]A",
      },
      goto_previous_start = {
        function_outer = "[f",
        class_outer = "[c",
        parameter_inner = "[a",
      },
      goto_previous_end = {
        function_outer = "[F",
        class_outer = "[C",
        parameter_inner = "[A",
      },
    },
  },
  ui = {
    nvim_notify = {
      dismiss_all_notifications = "<leader>un",
    },
    bufferline = {
      toggle_pin = "<leader>bp",
      delete_non_pinned_buffers = "<leader>bP",
      delete_other_buffers = "<leader>bo",
      delete_buffers_to_the_right = "<leader>br",
      delete_buffers_to_the_left = "<leader>bl",
      prev_buffer = "<S-h>",
      next_buffer = "<S-l>",
      prev_buffer_alt = "[b",
      next_buffer_alt = "]b",
      move_buffer_prev = "[B",
      move_buffer_next = "]B",
    },
    indent_blankline = {
      toggle = "<leader>ug",
    },
    noice = {
      prefix = "<leader>sn",
      redirect_cmdline = "<S-Enter>",
      last_message = "<leader>snl",
      history = "<leader>snh",
      all = "<leader>sna",
      dismiss = "<leader>snd",
      pick = "<leader>snt",
      scroll_forward = "<c-f>",
      scroll_backward = "<c-b>",
    },
    dashboard = {
      find_file = "f",
      new_file = "n",
      recent_files = "r",
      find_text = "g",
      config = "c",
      restore_session = "s",
      lazy_extras = "x",
      lazy = "l",
      quit = "q",
      projects = "p",
    },
  },
  util = {
    persistence = {
      restore_session = "<leader>qs",
      select_session = "<leader>qS",
      restore_last_session = "<leader>ql",
      skip_current_session = "<leader>qd",
    },
    mini_pairs = {
      toggle = "<leader>up",
    },
  },
  extras = {
    coding = {
      copilot_chat = {
        submit_prompt = "<c-s>",
        prefix = "<leader>a",
        toggle = "<leader>aa",
        clear = "<leader>ax",
        quick_chat = "<leader>aq",
        diagnostic_help = "<leader>ad",
        prompt_actions = "<leader>ap",
      },
      luasnip = {
        jump_next = "<tab>",
        jump_prev = "<s-tab>",
      },
      mini_surround = {
        prefix = "gs",
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
        alt = {
          prefix = "gz",
          add = "gza",
          delete = "gzd",
          find = "gzf",
          find_left = "gzF",
          highlight = "gzh",
          replace = "gzr",
          update_n_lines = "gzn",
        },
      },
      yanky = {
        yank_history = "<leader>p",
        yank = "y",
        put_text_after_cursor = "p",
        put_text_before_cursor = "P",
        put_text_after_selection = "gp",
        put_text_before_selection = "gP",
        cycle_forward_yank_history = "[y",
        cycle_backward_yank_history = "]y",
        put_indent_after_cursor_linewise = "]p",
        put_indent_before_cursor_linewise = "[p",
        put_indent_after_cursor_linewise_alt = "]P",
        put_indent_before_cursor_linewise_alt = "[P",
        put_and_indent_right = ">p",
        put_and_indent_left = "<p",
        put_before_indent_right = ">P",
        put_before_indent_left = "<P",
        put_after_filter = "=p",
        put_before_filter = "=P",
      },
    },
    dap = {
      core = {
        nvim_dap = {
          prefix = "<leader>d",
          breakpoint_condition = "<leader>dB",
          toggle_breakpoint = "<leader>db",
          continue = "<leader>dc",
          run_with_args = "<leader>da",
          run_to_cursor = "<leader>dC",
          go_to_line_no_execute = "<leader>dg",
          step_into = "<leader>di",
          down = "<leader>dj",
          up = "<leader>dk",
          run_last = "<leader>dl",
          step_out = "<leader>do",
          step_over = "<leader>dO",
          pause = "<leader>dp",
          toggle_repl = "<leader>dr",
          session = "<leader>ds",
          terminate = "<leader>dt",
          widgets = "<leader>dw",
        },
        nvim_dap_ui = {
          toggle_dap_ui = "<leader>du",
          eval_dap_ui = "<leader>de",
        },
      },
    },
    editor = {
      aerial = {
        toggle = "<leader>cs",
        aerial_telescope = "<leader>ss",
      },
      dial = {
        increment = "<C-a>",
        decrement = "<C-x>",
        increment_g = "g<C-a>",
        decrement_g = "g<C-x>",
      },
      harpoon2 = {
        harpoon_file = "<leader>H",
        harpoon_quick_menu = "<leader>h",
        harpoon_to_file_prefix = "<leader>",
      },
      vim_illuminate = {
        next = "]]",
        prev = "[[",
      },
      inc_rename = {
        rename = "<leader>cr",
      },
      leap = {
        next = "s",
        prev = "S",
        from_windows = "gs",
      },
      mini_diff = {
        toggle_overlay = "<leader>go",
      },
      mini_files = {
        open_current_file_dir = "<leader>fm",
        open_cwd = "<leader>fM",
      },
      outline = {
        up_and_jump = "<up>",
        down_and_jump = "<down>",
      },
      overseer = {
        prefix = "<leader>o",
        toggle = "<leader>ow",
        quick_action = "<leader>oq",
        run = "<leader>oo",
        info = "<leader>oi",
        build = "<leader>ob",
        task_action = "<leader>ot",
        clear_cache = "<leader>oc",
      },
      refactoring = {
        prefix = "<leader>r",
        refactor = "<leader>rs",
        inline_variable = "<leader>ri",
        extract_block = "<leader>rb",
        extract_block_to_file = "<leader>rf",
        debug_print = "<leader>rP",
        debug_print_variable = "<leader>rp",
        debug_cleanup = "<leader>rc",
        extract_function = "<leader>rf",
        extract_function_to_file = "<leader>rF",
        extract_variable = "<leader>rx",
      },
      picker = {
        switch_buffer = "<leader>,",
        grep_root = "<leader>/",
        command_history = "<leader>:",
        find_files_root = "<leader><space>",
        find_buffers = "<leader>fb",
        find_config_file = "<leader>fc",
        find_files_root_alt = "<leader>ff",
        find_files_cwd = "<leader>fF",
        find_git_files = "<leader>fg",
        find_recent_files = "<leader>fr",
        find_recent_files_cwd = "<leader>fR",
        find_projects = "<leader>fp",
        git_commits = "<leader>gc",
        git_status = "<leader>gs",
        search_registers = '<leader>s"',
        search_autocommands = "<leader>sa",
        search_buffer = "<leader>sb",
        search_command_history = "<leader>sc",
        search_commands = "<leader>sC",
        search_document_diagnostics = "<leader>sd",
        search_workspace_diagnostics = "<leader>sD",
        search_grep_root = "<leader>sg",
        search_grep_cwd = "<leader>sG",
        search_help_pages = "<leader>sh",
        search_highlight_groups = "<leader>sH",
        search_jumplist = "<leader>sj",
        search_keymaps = "<leader>sk",
        search_loclist = "<leader>sl",
        search_man_pages = "<leader>sM",
        search_marks = "<leader>sm",
        search_options = "<leader>so",
        search_resume = "<leader>sR",
        search_quickfix = "<leader>sq",
        search_word_root = "<leader>sw",
        search_word_cwd = "<leader>sW",
        search_selection_root = "<leader>sw",
        search_selection_cwd = "<leader>sW",
        colorscheme_preview = "<leader>uC",
        go_to_symbol = "<leader>ss",
        go_to_symbol_workspace = "<leader>sS",
        actions = {
          open_with_trouble = "<c-t>",
          open_with_trouble_alt = "<a-t>",
          find_files_no_ignore = "<a-i>",
          find_files_with_hidden = "<a-h>",
          cycle_history_next = "<C-Down>",
          cycle_history_prev = "<C-Up>",
          preview_scrolling_down = "<C-f>",
          preview_scrolling_up = "<C-b>",
          close = "q",
        },
        flash = {
          normal = "s",
          insert = "<c-s>",
        },
      },
    },
    test = {
      core = {
        prefix = "<leader>t",
        run_file = "<leader>tt",
        run_all_test_files = "<leader>tT",
        run_nearest = "<leader>tr",
        run_last = "<leader>tl",
        toggle_summary = "<leader>ts",
        show_output = "<leader>to",
        toggle_output_panel = "<leader>tO",
        stop = "<leader>tS",
        toggle_watch = "<leader>tw",
        debug_nearest = "<leader>td",
      },
    },
    lang = {
      lsp_info = "<leader>cl",
      mason = "<leader>cm",
      go_to_definition = "gd",
      go_to_declaration = "gD",
      references = "gr",
      file_references = "gR",
      go_to_implementation = "gI",
      go_to_type_definition = "gy",
      go_to_super = "gs",
      go_to_subjects = "gS",
      hover = "K",
      signature_help = "gK",
      insert_signature_help = "<c-k>",
      code_action = "<leader>ca",
      run_codelens = "<leader>cc",
      refresh_codelens = "<leader>cC",
      rename_file = "<leader>cR",
      rename = "<leader>cr",
      source_action = "<leader>cA",
      next_reference = "]]",
      prev_reference = "[[",
      cycle_next_reference = "<a-n>",
      cycle_prev_reference = "<a-p>",
      organize_imports = "<leader>co",
      add_missing_imports = "<leader>cM",
      remove_unused_imports = "<leader>cu",
      fix_all_diagnostics = "<leader>cD",
      select_lang_version = "<leader>cV",
      extract = {
        prefix = "<leader>cx",
        method = "<leader>cxm",
        variable = "<leader>cxv",
        constant = "<leader>cxc",
      },
      ansible = {
        ansible_run_playbook_role = "<leader>ta",
      },
      clangd = {
        switch_source_header = "<leader>cs",
      },
      clojure = {
        jump_prev_evaluation_output = "[c",
        jump_next_evaluation_output = "]c",
      },
      elixir = {
        to_pipe = "<leader>cp",
        from_pipe = "<leader>cP",
      },
      lean = {
        abbreviations_leader = "\\",
      },
      markdown = {
        markdown_preview_toggle = "<leader>cp",
        render_markdown_toggle = "<leader>um",
      },
      python = {
        debug_method = "<leader>dPt",
        debug_class = "<leader>dPc",
        select_virtual_env = "<leader>cv",
      },
      r = {
        send = "<Enter>",
        send_all = "<localleader>a",
        send_between_marks = "<localleader>b",
        send_chunks = "<localleader>c",
        send_functions = "<localleader>f",
        send_goto = "<localleader>g",
        send_install = "<localleader>i",
        send_knit = "<localleader>k",
        send_paragraph = "<localleader>p",
        send_quarto = "<localleader>q",
        send_general = "<localleader>r",
        send_split_or_send = "<localleader>s",
        send_terminal = "<localleader>t",
        send_view = "<localleader>v",
      },
      rust = {
        code_action = "<leader>cR",
        debuggables = "<leader>dr",
        show_crate_documentation = "K",
      },
      scala = {
        metals_commands = "<leader>me",
        metals_compile_cascade = "<leader>mc",
      },
      sql = {
        toggle_dbui = "<leader>D",
      },
      tex = {
        prefix = "<localLeader>l",
        vimtex_docs = "<Leader>K",
      },
      typescript = {
        go_to_source_definition = "gD",
      },
    },
    ui = {
      edgy = {
        toggle = "<leader>ue",
        select_window = "<leader>uE",
      },
      mini_animate = {
        toggle = "<leader>ua",
      },
      treesitter_context = {
        toggle = "<leader>ut",
      },
    },
    util = {
      chezmoi = {
        pick_chezmoi = "<leader>sz",
        select = "<CR>",
        key = "c",
      },
      octo = {
        issue_list = "<leader>gi",
        issue_search = "<leader>gI",
        pr_list = "<leader>gp",
        pr_search = "<leader>gP",
        repo_list = "<leader>gr",
        search = "<leader>gS",
        assignee = "<leader>a",
        comment_code = "<leader>c",
        label = "<leader>l",
        issue = "<leader>i",
        react = "<leader>r",
        pr = "<leader>p",
        review = "<leader>v",
        insert_at = "@",
        insert_hashtag = "#",
      },
      rest = {
        kulala = {
          prefix = "<leader>R",
          send_request = "<leader>Rs",
          toggle_view = "<leader>Rt",
          jump_to_previous_request = "<leader>Rp",
          jump_to_next_request = "<leader>Rn",
        },
      },
    },
    vscode = {
      find = "<leader><space>",
      find_in_files = "<leader>/",
      go_to_symbol = "<leader>ss",
    },
  },
}

---@return LazyVimKeymaps
M.get_keymaps = function()
  if keymaps == nil then
    keymaps = vim.tbl_deep_extend("force", {}, M.default_keymaps, vim.g.lazyvim_keymaps)
    vim.g.lazyvim_keymaps = keymaps -- update global for retrieval
  end
  return keymaps
end

return M
