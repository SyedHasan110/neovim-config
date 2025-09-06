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

vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

require("keymap")
require("general-settings")
require("lsp-progress")
