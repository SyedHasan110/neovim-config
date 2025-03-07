return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {},
    keys = {
        {
            "<a-t>",
            function()
                Snacks.terminal.toggle({
                    "bash"
                }, {
                    auto_insert = true,
                    start_insert = true,
                    win = {
                        border = "single",
                        focusable = true,
                        fixbuf = true,
                        minimal = false,
                        height = 0.8,
                        width = 0.7,
                        title = "  Terminal ",
                        title_pos = "center",
                        mouse = true,
                    }
                })
            end,
            desc = "Terminal"
        },
        {
            "<a-d>",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Diagnostics Buffer"
        }
    },
    config = function()
        require("snacks").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = {
                enabled = true,
                preset = {
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                }
            },
            explorer = { enabled = false },
            indent = {
                enabled = true,
                scope = {
                    hl = {
                        'RainbowDelimiterViolet',
                        'RainbowDelimiterRed',
                        'RainbowDelimiterYellow',
                        'RainbowDelimiterBlue',
                        'RainbowDelimiterOrange',
                        'RainbowDelimiterGreen',
                        'RainbowDelimiterCyan',
                    },
                    refresh = 10,
                },
            },
            input = { enabled = true, icon = " " },
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
            scroll = {
                enabled = false,
            },
            statuscolumn = {
                enabled = true,
                left = { 'mark', 'sign' },
                right = { 'fold', 'git' },
                folds = {
                    git_hl = true,
                    open = true
                },
                git = {},
                refresh = 20
            },
            words = {
                enabled = true,
            },

        })
    end
}
