vim.o.number = true
require("config.lazy")
for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
	vim.fn.sign_define("DiagnosticSign" .. diag, {
		text = "",
		texthl = "DiagnosticSign" .. diag,
		linehl = "",
		numhl = "DiagnosticSign" .. diag,
	})
end
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Could be '●', '▎', 'x'
	},
	update_in_insert = true,
	severity_sort = true,
})


vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = "lualine_augroup",
	pattern = "LspProgressStatusUpdated",
	callback = require("lualine").refresh,
})
vim.opt.list = true
vim.opt.listchars = {
	space = '‧', -- Show spaces as middle dots (·)
	tab = '‧‧', -- Show tabs as arrows followed by a space (→)
	trail = '‧', -- Show trailing spaces as dots (·)
	nbsp = '‧',
}

vim.api.nvim_set_hl(0, "Visual", { link = "Visual", bg = "#3a3f58", })
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#6d7999", })

vim.opt.wrap = true
local ft = require("terminal")
ft.setup({
	shell = "bash", -- Change default shell
	border = "single", -- Border style
	width = 0.65,  -- Relative width
	height = 0.7,  -- Relative height
	title_pos = "center", -- Title alignment
	esc_close = true, -- Disable Esc closing
	title = "  Terminal ",

})
require("keymap")
