return {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "nvcheatsheet", "neo-tree" },
            callback = function()
                require("ufo").detach()
                vim.opt_local.foldenable = false
            end
        })
        vim.o.foldcolumn = '0' -- '0' is not bad
        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        require("ufo").setup({
            preview = {},
            close_fold_kinds_for_ft = {},
            enable_get_fold_virt_text = true,
            open_fold_hl_timeout = 10,
        })
    end
}
