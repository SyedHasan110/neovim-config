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
    callback = function()
        require("lualine").refresh()
    end
})

require("keymap")
require("general-settings")
require("lsp-progress")
