return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        vim.schedule(function()
            require('rainbow-delimiters.setup').setup({
                highlight = {
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterCyan',
                }
            })
        end)
    end
}
