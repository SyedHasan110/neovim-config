return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            no_italic = true,
            integrations = {
                blink_cmp = true,
                neotree = true,
                native_lsp = {
                    enabled = true,
                    inlay_hints = {
                        background = true
                    },
                },
                telescope = {
                    enabled = true,
                },
                treesitter = true,
                markdown = true,
                render_markdown = true,
                mason = true,
            },
        })
        vim.cmd.colorscheme("catppuccin-mocha")
    end
}
