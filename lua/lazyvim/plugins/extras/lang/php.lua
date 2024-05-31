local handle = io.popen("php -v")
if handle ~= nil then
    local result = handle:read("*a")
    io.close(handle)
    if not string.find(result, "8.") then
        Lsp_server = "intelephense"
    else
        Lsp_server = "phpactor"
    end
end

return {
    recommended = function()
        return LazyVim.extras.wants({
            ft = { "php", "phpdoc" },
            root = { "vendor" },
        })
    end,
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "php",
                "phpdoc",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                [Lsp_server] = {},
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { Lsp_server })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    vim.list_extend(opts.ensure_installed, { "php-cs-fixer" })
                end,
            },
        },
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.formatting.phpcsfixer,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                php = { "phpcsfixer" },
            },
        },
    },
}
