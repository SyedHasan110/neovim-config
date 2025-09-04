return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm", -- "storm", "night", "moon"
		transparent = false,
		styles = {
			sidebars = "dark",
			floats = "dark",
		},
	},

	config = function()
		require("tokyonight").setup({
			on_highlights = function(hl, colors)
				-- Make statusline blend with background
				hl.NvimTreeWinSeparator = {
					fg = colors.bg,
					bg = colors.bg, -- Match editor background
				}
			end,
			style = "night", -- "storm", "night", "moon"
			transparent = false,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				functions = {},
				variables = {},
				sidebars = "dark",
				floats = "dark",
			},
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
