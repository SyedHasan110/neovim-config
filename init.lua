vim.o.number = true

vim.opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
vim.opt.softtabstop = 4 -- 4 spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- 4 spaces for indent width
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.expandtab = true -- expand tabs
vim.opt.smartindent = true -- indents smartindent
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = {
	space = "‧", -- Show spaces as middle dots (·)
	tab = "‧‧", -- Show tabs as arrows followed by a space (→ )
	trail = "‧", -- Show trailing spaces as dots (·)
	nbsp = "‧",
}

vim.diagnostic.config({
	underline = true,
	virtual_text = {
		current_line = nil,
		prefix = "●", -- Could be '●', '▎', 'x'
	},
	update_in_insert = true,
	severity_sort = true,
	signs = false,
})

vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

require("config.lazy")
require("lsp-progress")
require("keymap")
