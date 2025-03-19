return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
        -- Custom LSP component for lualine
        local function lsp_component()
            -- Get active LSP clients for the current buffer
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then return "" end
            -- List of preferred LSP servers (add your installed servers here)
            local preferred_servers = require("mason-lspconfig").get_installed_servers()
            -- Find the first active server in the preferred list
            for _, preferred in ipairs(preferred_servers) do
                for _, client in ipairs(clients) do
                    if client.name == preferred then
                        return " " .. client.name -- Optional icon (e.g., , )
                    end
                end
            end

            return "" -- No preferred server found
        end
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
                disabled_filetypes = {},
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = true,
                update_in_insert = true,
                refresh = {
                    statusline = 50,
                    tabline = 100,
                    winbar = 100,
                },
            },
            sections = {
                lualine_a = { { "mode", icon = "" } },
                lualine_b = { { "branch", icon = "" }, { "diff", icon = "" } },
                lualine_c = { { lsp_component } },
                lualine_x = { "diagnostics", "filesize", "encoding", "filetype" },
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
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,

}
