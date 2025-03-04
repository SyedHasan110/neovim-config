return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {},
    config = function()
        require("snacks").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = false },
            indent = { enabled = true },
            input = { enabled = true },
            picker = {
                enabled = true,
                icons = {
                    diagnostics = {
                        Error = "",
                        Hint = "",
                        Warn = "",
                        Info = ""
                    },
                    files = {
                        dir = "",
                        dir_open = "",
                        enabled = true,
                        file = ""
                    },
                    keymaps = {
                        nowait = ""
                    },
                    tree = {},
                    git = {
                        added = "",
                        commit = "",
                        deleted = "",
                        ignored = "",
                        modified = "",
                        renamed = "",
                        staged = "",
                        unmerged = ""
                    },
                    kinds = {
                        Array         = " ",
                        Boolean       = " ",
                        Class         = " ",
                        Color         = " ",
                        Control       = " ",
                        Collapsed     = " ",
                        Constant      = " ",
                        Constructor   = " ",
                        Copilot       = " ",
                        Enum          = " ",
                        EnumMember    = " ",
                        Event         = " ",
                        Field         = " ",
                        File          = " ",
                        Folder        = " ",
                        Function      = " ",
                        Interface     = " ",
                        Key           = " ",
                        Keyword       = " ",
                        Method        = " ",
                        Module        = " ",
                        Namespace     = "󰦮 ",
                        Null          = " ",
                        Number        = "󰎠 ",
                        Object        = " ",
                        Operator      = " ",
                        Package       = " ",
                        Property      = " ",
                        Reference     = " ",
                        Snippet       = "󱄽 ",
                        String        = " ",
                        Struct        = " ",
                        Text          = " ",
                        TypeParameter = " ",
                        Unit          = " ",
                        Unknown       = " ",
                        Value         = " ",
                        Variable      = " ",
                    },
                    lsp = {
                        attached = "",
                        disabled = "󰨙",
                        enabled = "󰔡"
                    },
                    ui = {},
                    undo = {}
                }
            },
            notifier = {
                enabled = true,
                icons = {
                    debug = "",
                    info = "",
                    error = "",
                    warn = ""
                },
            },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },

        })
    end
}
