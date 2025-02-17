return {
    "rachartier/tiny-devicons-auto-colors.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local theme_colors = require("catppuccin.palettes").get_palette("mocha")
        require('tiny-devicons-auto-colors').setup({
            autoreload = true,
            colors = theme_colors
        })
    end
}
