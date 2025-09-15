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
				all = true,
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
			end,
			on_highlights = function(highlights, colors)
				highlights.NvimTreeWinSeparator = {
					bg = colors.bg,
					fg = colors.bg,
				}
				highlights.NvimTreeModifiedIcon = {
					fg = colors.warning,
				}
				highlights.DiagnosticUnderlineError.undercurl = nil
				highlights.DiagnosticUnderlineError.underdashed = true

				highlights.DiagnosticUnderlineWarn.undercurl = nil
				highlights.DiagnosticUnderlineWarn.underdashed = true

				highlights.DiagnosticUnderlineInfo.undercurl = nil
				highlights.DiagnosticUnderlineInfo.underdashed = true

				highlights.DiagnosticUnderlineHint.undercurl = nil
				highlights.DiagnosticUnderlineHint.underdashed = true

				highlights["@lsp.type.unresolvedReference"].undercurl = nil
				highlights["@lsp.type.unresolvedReference"].underdashed = true
			end,
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}
