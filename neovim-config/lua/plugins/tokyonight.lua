return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			on_highlights = function(hl, colors)
				-- Make statusline blend with background
				hl.NvimTreeWinSeparator = {
					fg = colors.bg,
					bg = colors.bg, -- Match editor background
				}
				hl.DiagnosticUnderlineError = {
					underdashed = true,
				}
				hl.DiagnosticUnderlineWarn = {
					underdashed = true,
				}
				hl.DiagnosticUnderlineInfo = {
					underdashed = true,
				}
				hl.DiagnosticUnderlineHint = {
					underdashed = true,
				}

				hl.DiagnosticVirtualTextError = { fg = colors.red1 }
				hl.DiagnosticVirtualTextWarn = { fg = colors.yellow }
				hl.DiagnosticVirtualTextInfo = { fg = colors.blue2 }
				hl.DiagnosticVirtualTextHint = { fg = colors.green }
			end,
			on_colors = function() end,
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
			plugins = {
				all = true,
			},
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
