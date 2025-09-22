return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	config = function()
		vim.lsp.config("*", {
			settings = {
				Lua = {
					diagnostics = {
						workspaceEvent = "OnChange",
					},
					format = {
						enable = true,
					},
					hint = {
						enable = true,
					},
				},

				["rust-analyzer"] = {
					inlayHints = {
						discriminantHints = {
							enable = "always",
						},
					},
					semanticHighlighting = {
						operator = {
							specialization = {
								enable = true,
							},
						},
						punctuation = {
							enable = true,
							separate = {
								macro = {
									bang = true,
								},
							},
							specialization = {
								enable = true,
							},
						},
					},
				},
			},
		})
	end,
}
