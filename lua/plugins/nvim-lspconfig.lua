return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	config = function()
		vim.lsp.config("rust_analyzer", {
			settings = {
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

		vim.lsp.config("lua_ls", {
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
			},
		})
	end,
}
