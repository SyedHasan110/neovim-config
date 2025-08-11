vim.o.number = true
require("config.lazy")
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Could be '●', '▎', 'x'
	},
	update_in_insert = true,
	severity_sort = true,
	signs = false,
})

require("keymap")
require("general-settings")
require("lsp-progress")
