return {
	{
		"williamboman/mason.nvim",
		opts = {},
		config = function()
			require("mason").setup({
				ui = {
					---@since 1.0.0
					-- Whether to automatically check for new versions when opening the :Mason window.
					check_outdated_packages_on_open = true,

					---@since 1.0.0
					-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
					border = "double",

					---@since 1.0.0
					-- Width of the window. Accepts:
					-- - Integer greater than 1 for fixed width.
					-- - Float in the range of 0-1 for a percentage of screen width.
					width = 0.8,

					---@since 1.0.0
					-- Height of the window. Accepts:
					-- - Integer greater than 1 for fixed height.
					-- - Float in the range of 0-1 for a percentage of screen height.
					height = 0.9,

					icons = {
						---@since 1.0.0
						-- The list icon to use for installed packages.
						package_installed = "✓ ",

						---@since 1.0.0
						-- The list icon to use for packages that are installing, or queued for installation.
						package_pending = " ",
						---@since 1.0.0
						-- The list icon to use for packages that are not installed.
						package_uninstalled = "✗ ",
					},
				},
			})
			local mr = require("mason-registry")
			local packages = {
				"stylua",
				"html-lsp",
				"emmet-language-server",
				"biome",
				"deno",
			}
			mr.refresh(function()
				for _, tool in ipairs(packages) do
					local pkg = mr.get_package(tool)
					if not pkg:is_installed() then
						pkg:install()
					end
				end
			end)
		end,
	},
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
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"taplo",
					"clangd",
					"cssls",
				},
			})
		end,
	},
	{
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
						format = {
							enable = true,
						},
						hint = {
							enable = true,
						},
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client.name == "rust_analyzer" then
						vim.defer_fn(function()
							vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
						end, 3000)
					else
						vim.defer_fn(function()
							vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
						end, 1000)
					end
				end,
			})

			-- This works for Lua files
			vim.api.nvim_create_autocmd("CursorHold", {
				pattern = { "*.lua" },
				callback = function()
					local bufnr = vim.api.nvim_get_current_buf()
					vim.diagnostic.reset()
					vim.diagnostic.enable(true, { bufnr = bufnr })
				end,
			})
			vim.lsp.enable("denols")
		end,
	},
}
