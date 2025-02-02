return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    ---@since 1.0.0
                    -- Whether to automatically check for new versions when opening the :Mason window.
                    check_outdated_packages_on_open = true,

                    ---@since 1.0.0
                    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
                    border = "rounded",

                    ---@since 1.0.0
                    -- Width of the window. Accepts:
                    -- - Integer greater than 1 for fixed width.
                    -- - Float in the range of 0-1 for a percentage of screen width.
                    width = 0.8,

                    ---@since 1.0.0
                    -- Height of the window. Accepts:
                    -- - Integer greater than 1 for fixed height.
                    -- - Float in the range of 0-1 for a percentage of screen height.
                    height = 0.9,

                    icons = {
                        ---@since 1.0.0
                        -- The list icon to use for installed packages.
                        package_installed = "✓ ",

                        ---@since 1.0.0
                        -- The list icon to use for packages that are installing, or queued for installation.
                        package_pending = " ",
                        ---@since 1.0.0
                        -- The list icon to use for packages that are not installed.
                        package_uninstalled = "✗ ",




                    },
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
                -- This setting has no relation with the `ensure_installed` setting.
                -- Can either be:
                --   - false: Servers are not automatically installed.
                --   - true: All servers set up via lspconfig are automatically installed.
                --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
                --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
                ---@type boolean
                automatic_installation = true,
                ensure_installed = { "lua_ls", "rust_analyzer", "taplo" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { 'saghen/blink.cmp' },
        opts = {
            inlayHints = {
                enable = true
            },
        },
        config = function()
            local servers = { "lua_ls", "rust_analyzer", "taplo" }
            local lspconfig = require("lspconfig")

            local capabilities = require("blink.cmp").get_lsp_capabilities()
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    settings = {
                        Lua = {
                            hint = {
                                enable = true
                            }
                        },
                        ["rust-analyzer"] = {
                            inlayHints = {
                                reborrowHints = {
                                    enable = "always"
                                },
                                lifetimeElisionHints = {
                                    enable = "always"
                                },
                                implicitSizedBoundHints = {
                                    enable = true
                                },
                                implicitDrops = {
                                    enable = true
                                },
                                genericParameterHints = {
                                    type = {
                                        enable = true
                                    },
                                    lifetime = {
                                        enable = true
                                    }
                                },
                                discriminantHints = {
                                    enable = "always"
                                }
                            }
                        }
                    },
                    on_attach = function(client, bufnr)
                        vim.opt.updatetime = 200
                        if client.server_capabilities.inlayHintProvider then
                            vim.api.nvim_create_autocmd({ "CursorHold" },
                                {
                                    callback = function()
                                        vim.lsp.inlay_hint.enable(true,
                                            { bufnr = bufnr })
                                    end
                                })
                        end
                    end,
                    capabilities = capabilities
                })
            end
        end
    }
}
