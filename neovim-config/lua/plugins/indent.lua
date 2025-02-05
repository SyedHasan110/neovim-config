return {
    "nvimdev/indentmini.nvim",
    config = function()
        require("indentmini").setup({
            -- Colors are applied automatically based on user-defined highlight groups.
            -- There is no default value.
            vim.cmd.highlight('IndentLine guifg=#6c6f85'),
            -- Current indent line highlight
            vim.cmd.highlight('IndentLineCurrent guifg=#9ca0b0')
        })
    end
}
