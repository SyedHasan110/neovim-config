return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            no_italic = true,
            integrations = {
                blink_cmp = true,
                nvimtree = true,
                native_lsp = {
                    inlay_hints = {
                        background = true
                    },
                    enabled = true,
                },
                telescope = {
                    enabled = true,
                },
                treesitter = true,
                markdown = true,
                render_markdown = true,
                mason = true,
                semantic_tokens = true,
                treesitter_context = true,
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end
}
