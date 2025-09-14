return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			style = "night",
			light_style = "day",
			cache = true,
			day_brightness = 0.3,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				functions = {},
				variables = {},
			},
			plugins = {
				mason = true,
				lazy = true,
				snacks = true,
				auto = true,
			},
			transparent = false,
			dim_inactive = false,
			lualine_bold = false,
			terminal_colors = true,
			on_colors = function(colors)
				colors.error = colors.red
				colors.warning = colors.yellow
				colors.info = colors.blue
				colors.hint = colors.green1
				colors.bg_visual = colors.bg_highlight
			end,
			on_highlights = function(highlights, colors)
				highlights.NvimTreeWinSeparator = {
					bg = colors.bg,
					fg = colors.bg,
				}
				highlights.DiagnosticUnderlineError = {
					underdashed = true,
				}

				highlights.DiagnosticUnderlineWarn = {
					underdashed = true,
				}

				highlights.DiagnosticUnderlineInfo = {
					underdashed = true,
				}
				highlights.DiagnosticUnderlineHint = {
					underdashed = true,
				}
				highlights.NvimTreeModifiedIcon = {
					fg = colors.yellow,
					link = nil,
					global_link = nil,
				}
			end,
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}
