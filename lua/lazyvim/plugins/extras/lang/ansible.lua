return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "yaml.ansible",
      root = { "ansible.cfg", ".ansible-lint" },
    })
  end,
  {
    "mason-org/mason.nvim",
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
    ft = { "yaml" },
    keys = {
      {
        "<leader>ta",
        function()
          require("ansible").run()
        end,
        ft = "yaml.ansible",
        desc = "Ansible Run Playbook/Role",
        silent = true,
      },
    },
  },
}
