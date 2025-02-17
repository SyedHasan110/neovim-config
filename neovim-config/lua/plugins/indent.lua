return {
    "nvimdev/indentmini.nvim",
    config = function()
        require("indentmini").setup({
            -- Colors are applied automatically based on user-defined highlight groups.
            -- There is no default value.
            vim.cmd.highlight('IndentLine guifg=#7c7f93'),
            -- Current indent line highlight
            vim.cmd.highlight('IndentLineCurrent guifg=#ccd0da')
        }) -- use default config
    end
}
