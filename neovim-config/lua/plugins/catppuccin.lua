return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            term_colors = true,
            no_italic = true,
            integrations = {
                notify = true,
                window_picker = true,
                symbols_outline = true,
                dashboard = true,
                snacks = true,
                blink_cmp = true,
                nvimtree = true,
                native_lsp = {
                    underlines = {
                        errors = {
                            "underdashed"
                        },
                        information = {
                            "underdashed"
                        },
                        hints = {
                            "underdashed"
                        },
                        ok = {
                            "underdashed"
                        },
                        warnings = {
                            "underdashed"
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
                fzf = true,
                treesitter_context = true,
                rainbow_delimiters = true,

            },
        })
        vim.cmd.colorscheme("catppuccin")
    end
}
