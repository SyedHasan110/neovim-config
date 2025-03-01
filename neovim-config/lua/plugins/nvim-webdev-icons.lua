return {
    require("nvim-web-devicons").set_default_icon("", "#f7f9fa"),
    require("nvim-web-devicons").setup({
        -- your personal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override                     = {
            zsh = {
                icon = "",
                color = "#428850",
                cterm_color = "65",
                name = "Zsh",
            },
        },
        -- globally enable different highlight colors per icon (default to true)
        -- if set to false all icons will have the default icon's color
        color_icons                  = true,
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default                      = true,
        -- globally enable "strict" selection of icons - icon will be looked up in
        -- different tables, first by filename, and if not found by extension; this
        -- prevents cases when file doesn't have any extension but still gets some icon
        -- because its name happened to match some extension (default to false)
        strict                       = true,
        -- set the light or dark variant manually, instead of relying on `background`
        -- (default to nil)
        variant                      = "dark",
        -- same as `override` but specifically for overrides by filename
        -- takes effect when `strict` is true
        override_by_filename         = {
            [".gitignore"] = {
                icon = "",
                color = "#f2762e",
                name = "Gitignore",
            },
        },
        -- same as `override` but specifically for overrides by extension
        -- takes effect when `strict` is true
        override_by_extension        = {
            ["log"]        = {
                icon = "",
                color = "#81e043",
                name = "Log",
            },
            ["toml"]       = {
                icon = "",
                color = "#f57047",
                name = "Toml",
            },
            ["lock"]       = {
                icon = "",
                color = "#f7f9fa",
                name = "Lock",
            },
            ["json5"]      = {
                icon = "",
                color = "#ffd726",
                name = "JSON"
            },
            ["json"]       = {
                icon = "",
                color = "#ffd726",
                name = "JSON"
            },
            ["js"]         = {
                icon = "",
                cterm_color = 185,
                color = "#ffd726",
                name = "JavaScript"
            },
            default        = {
                icon = "",
                color = "#f7f9fa",
                name = "Default"
            },
            ["conf"]       = {
                icon = "",
                name = "conf"
            },
            ["ini"]        = {
                icon = "",
                name = "ini"
            },
            ["tag"]        = {
                icon = "",
                name = "Tag"
            },
            ["cargo-lock"] = {
                icon = "",
                color = "#f7f9fa",
                name = "cargo-lock"
            },
            ["timestamp"]  = {
                icon = "",
                name = "Timestamp"
            },
            ["bin"]        = {
                icon = "",
                color = "#fab387",
                name = "Binary"
            },
            ["o"]          = {
                icon = "",
                color = "#fab387",
                name = "Binary"
            }

        },
        -- same as `override` but specifically for operating system
        -- takes effect when `strict` is true
        override_by_operating_system = {
            ["apple"] = {
                icon = "",
                color = "#A2AAAD",
                cterm_color = "248",
                name = "Apple",
            },
        },
    }),
}
