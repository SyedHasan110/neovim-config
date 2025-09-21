return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
				-- This setting has no relation with the `ensure_installed` setting.
				-- Can either be:
				--   - false: Servers are not automatically installed.
				--   - true: All servers set up via lspconfig are automatically installed.
				--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
				--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
				---@type boolean
				automatic_installation = true,
				automatic_enable = true,
				ensure_installed = {},
			})
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
	},
}
