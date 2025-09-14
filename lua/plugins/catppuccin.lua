return {
	"catppuccin/nvim",
	name = "catppuccin",
	commit = "8076ba30b74b5902b3fed1e5176855158c5ba551",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			show_end_of_buffer = false,
			no_italic = true,
			float = {
				solid = false,
				transparent = false,
			},
			integrations = {
				native_lsp = {
					enabled = true,
					inlay_hints = {
						background = true,
					},
					underlines = {
						errors = { "underdashed" },
						information = { "underdashed" },
						hints = { "underdashed" },
						warnings = { "underdashed" },
					},
				},
				blink_cmp = true,
				dashboard = true,
				window_picker = true,
				vimwiki = true,
				treesitter_context = true,
				treesitter = true,
				snacks = true,
				barbar = false,
				fzf = true,
				gitgraph = true,
				gitgutter = true,
				gitsigns = true,
				markdown = true,
				markview = true,
				render_markdown = true,
				rainbow_delimiters = true,
				telescope = true,
				which_key = true,
				nvimtree = true,
				notify = true,
				nvim_surround = true,
				vim_sneak = true,
				neogit = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
