return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = "",
                section_separators = { left = '', right = '' },
                -- disabled_filetypes = {
                --   statusline = {},
                --   winbar = {},
                -- },
                disabled_filetypes = { "neo-tree" },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = true,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                },
            },
            sections = {
                lualine_a = { { "mode", icon = "" } },
                lualine_b = { { "branch", icon = "" }, { "diff", icon = "" }, "diagnostics" },
                lualine_c = {
                    function()
                        return require('lsp-progress').progress({})
                    end
                },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { { "location", icon = "" } },
            },
            inactive_sections = {
                lualine_a = { { "mode", icon = "" } },
                lualine_b = { { "branch", icon = "" }, { "diff", icon = "" }, "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { { "location", icon = "" } },
            },
            tabline = {

            },
            winbar = {},
            inactive_winbar = {},
            extensions = {},

        })
    end,

}
