return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {},
    keys = {
        {
            "<a-t>",
            mode = { "n", "t", "v" },
            function()
                Snacks.terminal.toggle("bash", {
                    win = {
                        border = "single",
                        title = "  Terminal ",
                        title_pos = "center",
                        enter = true,
                        focusable = true,
                        width = 0.7,
                        height = 0.8,
                        backdrop = 45,
                    }
                })
            end
        },
        {
            "<a-d>",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Diagnostics Buffer"
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols({
                    live = true,
                })
            end,
            desc = "LSP Workspace Symbols"
        },
    },
    config = function()
        local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
        vim.api.nvim_create_autocmd("User", {
            pattern = "NvimTreeSetup",
            callback = function()
                local events = require("nvim-tree.api").events
                events.subscribe(events.Event.NodeRenamed, function(data)
                    if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
                        data = data
                        Snacks.rename.on_rename_file(data.old_name, data.new_name)
                    end
                end)
            end,
        })
        require("snacks").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = false },
            dashboard = {
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { Snacks.dashboard.sections.startup({ icon = "  " }) }
                },
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
            scope = {
                enabled = true,
                debounce = 10,
            },
            scroll = {
                enabled = false,
            },
            statuscolumn = {
                enabled = true,
                left = { "mark", "sign" },
                right = { "fold", "git" },
                folds = {
                    open = true
                },
            },
            words = {
                enabled = true,
                debounce = 30,
            },
            styles = {
                notification = {
                    relative = "editor",
                    border = "single",
                    wo = {
                        winblend = 0,
                    }
                }
            }
        })
    end
}
