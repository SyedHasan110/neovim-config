return {
    "lewis6991/hover.nvim",
    config = function()
        require("hover").setup {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                -- require('hover.providers.gh')
                -- require('hover.providers.gh_user')
                -- require('hover.providers.jira')
                -- require('hover.providers.dap')
                -- require('hover.providers.fold_preview')
                require('hover.providers.diagnostic')
                require('hover.providers.man')
                -- require('hover.providers.dictionary')
            end,
            preview_opts = {
                border = 'single'
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = true,
            title = true,
            mouse_providers = {
                'LSP'
            },
            mouse_delay = 100
        }

        -- Setup keymaps
        vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
        vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
        vim.keymap.set("n", "<C-p>",
            function() require("hover").hover_switch("previous", { bufnr = 0, pos = {} }) end,
            { desc = "hover.nvim (previous source)" })
        vim.keymap.set("n", "<C-n>",
            function() require("hover").hover_switch("next", { bufnr = 0, pos = {} }) end,
            { desc = "hover.nvim (next source)" })
    end
}
