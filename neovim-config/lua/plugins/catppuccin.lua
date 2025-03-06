return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            no_italic = true,
            integrations = {
                symbols_outline = true,
                dashboard = true,
                snacks = true,
                blink_cmp = true,
                nvimtree = true,
                native_lsp = {
                    underlines = {
                        errors = {
                            "undercurl"
                        },
                        information = {
                            "undercurl"
                        },
                        hints = {
                            "undercurl"
                        },
                        ok = {
                            "undercurl"
                        },
                        warnings = {
                            "undercurl"
                        }
                    },
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
                rainbow_delimiters = true,
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end
}
