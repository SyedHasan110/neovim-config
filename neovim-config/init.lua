vim.o.number = true
require("config.lazy")
vim.diagnostic.config({
    virtual_text = {
        prefix = "●", -- Could be '●', '▎', 'x'
    },
    update_in_insert = true,
    severity_sort = true,
    signs = false
})

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
    group = "lualine_augroup",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
})

local ft = require("terminal")
ft.setup({
    shell = "bash",       -- Change default shell
    border = "single",    -- Border style
    width = 0.65,         -- Relative width
    height = 0.7,         -- Relative height
    title_pos = "center", -- Title alignment
    esc_close = true,     -- Disable Esc closing
    title = "  Terminal ",

})
require("keymap")
require("whitespace")
require("general-settings")
require("general-settings")
