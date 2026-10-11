---@module "luassert"

describe("chezmoi source paths", function()
  local saved, group, watches

  before_each(function()
    saved = {
      executable = vim.fn.executable,
      system = vim.system,
      create_autocmd = vim.api.nvim_create_autocmd,
      data_home = vim.env.XDG_DATA_HOME,
      source_dir = vim.g["chezmoi#source_dir_path"],
      use_tmp_buffer = vim.g["chezmoi#use_tmp_buffer"],
      edit = package.loaded["chezmoi.commands.__edit"],
    }
    group = vim.api.nvim_create_augroup("ChezmoiTest", { clear = true })
    vim.api.nvim_create_autocmd = function(events, opts)
      opts.group = group
      return saved.create_autocmd(events, opts)
    end
    vim.env.XDG_DATA_HOME = vim.fn.tempname()
    vim.g["chezmoi#source_dir_path"] = "/stale/source"
    watches = 0
    package.loaded["chezmoi.commands.__edit"] = {
      watch = function()
        watches = watches + 1
      end,
    }
  end)

  after_each(function()
    vim.api.nvim_del_augroup_by_id(group)
    vim.api.nvim_create_autocmd = saved.create_autocmd
    vim.fn.executable = saved.executable
    vim.system = saved.system
    vim.env.XDG_DATA_HOME = saved.data_home
    vim.g["chezmoi#source_dir_path"] = saved.source_dir
    vim.g["chezmoi#use_tmp_buffer"] = saved.use_tmp_buffer
    package.loaded["chezmoi.commands.__edit"] = saved.edit
  end)

  for _, case in ipairs({
    { name = "uses the configured source root, including spaces", code = 0 },
    { name = "delegates filetype detection when the command fails", code = 1 },
    { name = "delegates filetype detection when chezmoi is missing", missing = true },
    { name = "watches the default data directory when XDG_DATA_HOME is unset", code = 1, default = true },
    { name = "watches XDG_DATA_HOME with a trailing slash", code = 1, trailing = true },
  }) do
    it(case.name, function()
      if case.default then
        vim.env.XDG_DATA_HOME = nil
      elseif case.trailing then
        vim.env.XDG_DATA_HOME = vim.env.XDG_DATA_HOME .. "/"
      end
      local root = case.code == 0 and vim.fn.tempname() .. "/custom source/home"
        or vim.fs.joinpath(vim.env.XDG_DATA_HOME or vim.env.HOME .. "/.local/share", "chezmoi")
      vim.fn.executable = function(command)
        assert.are.equal("chezmoi", command)
        return case.missing and 0 or 1
      end
      vim.system = function(command, opts)
        assert.is_false(case.missing == true)
        assert.same({ "chezmoi", "source-path" }, command)
        assert.is_true(opts.text)
        return {
          wait = function()
            return { code = case.code, stdout = root .. "\n" }
          end,
        }
      end

      local spec = dofile("lua/lazyvim/plugins/extras/util/chezmoi.lua")
      spec[1].init()
      if case.code == 0 then
        assert.are.equal(root, vim.g["chezmoi#source_dir_path"])
      else
        assert.is_nil(vim.g["chezmoi#source_dir_path"])
      end
      spec[2].init()

      for _, event in ipairs({ "BufRead", "BufNewFile" }) do
        vim.api.nvim_exec_autocmds(event, { pattern = root .. "/.chezmoiscripts/run_after_example.sh.tmpl" })
      end
      assert.is_true(vim.wait(1000, function()
        return watches == 2
      end))
      for _, event in ipairs({ "BufRead", "BufNewFile" }) do
        vim.api.nvim_exec_autocmds(event, { pattern = root .. "-other/example.sh.tmpl" })
      end
      vim.wait(20, function()
        return false
      end)
      assert.are.equal(2, watches)
    end)
  end
end)
