return {
	-- lazy.nvim
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			-- NOTE: The log_level is in `opts.opts`
			opts = {
				log_level = "DEBUG", -- or "TRACE"
			},
		},

		config = function()
			require("codecompanion").setup({
				display = {
					chat = {
						window = {
							layout = "vertical", -- ✅ Required for split behavior
							position = "right",
							width = 60,
						},
					},
				},
			})
		end,
	},
}
