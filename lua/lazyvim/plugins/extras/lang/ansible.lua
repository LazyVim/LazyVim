local k = require("lazyvim.keymaps").get_keymaps()

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "yaml.ansible",
      root = { "ansible.cfg", ".ansible-lint" },
    })
  end,
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "ansible-lint" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {},
      },
    },
  },
  {
    "mfussenegger/nvim-ansible",
    ft = {},
    keys = {
      {
        k.ansible_run_playbook_role,
        function()
          require("ansible").run()
        end,
        desc = "Ansible Run Playbook/Role",
        silent = true,
      },
    },
  },
}
