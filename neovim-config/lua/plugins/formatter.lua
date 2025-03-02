return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            format_on_save = {
                -- These options will be passed to conform.format()
                lsp_format = "fallback",
            },
            format_after_save = {
                undojoin = true,
                lsp_format = "fallback",
                async = true
            },
            formatters_by_ft = {
                lua = { "stylua", lsp_format = "fallback" },
                -- Conform will run multiple formatters sequentially
                -- python = { "isort", "black" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },
        })
    end
}
