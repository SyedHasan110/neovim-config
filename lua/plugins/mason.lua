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
			local lsp_pkg = {
				"html-lsp",
				"emmet-language-server",
				"deno",
				"lua-language-server",
				"rust-analyzer",
				"clangd",
				"json-lsp",
				"css-lsp",
				"taplo",
			}

			local fmt_pkg = {
				"biome",
				"stylua",
			}

			local mpkgs = {}
			table.move(lsp_pkg, 1, #lsp_pkg, 1, mpkgs)
			table.move(fmt_pkg, 1, #fmt_pkg, #mpkgs + 1, mpkgs)
			mr.refresh(function()
				for _, pkgs in ipairs(mpkgs) do
					local pkg = mr.get_package(pkgs)
					if not pkg.is_installed(pkg) then
						pkg.install(pkg)
					end
				end
			end)

			vim.lsp.enable(lsp_pkg)

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client_name = vim.lsp.get_client_by_id(args.data.client_id).name
					local bufnr = args.buf
					if client_name == "lua_ls" then
						vim.defer_fn(function()
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end, 2000)
					else
						if client_name == "rust_analyzer" then
							vim.defer_fn(function()
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end, 3000)
						else
							vim.defer_fn(function()
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end, 1000)
						end
					end
				end,
			})
		end,
	},
}
