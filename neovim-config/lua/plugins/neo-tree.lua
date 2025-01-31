return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		vim.keymap.set("n", "<C-e>", "<Cmd>Neotree toggle<CR>")
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true
				}
			},
			retain_hidden_root_indent = true,
			hide_root_node = true,
			window = {
				position = "left",
				mappings = {
					["<leader>e"] = "toggle_preview",
				},
			},
			source_selector = {
				winbar = true,
				statusline = false,
				sources = {
					{
						source = "filesystem", -- string
						display_name = " File Explorer " -- string | nil
					},
				},
				content_layout = "center"
			},
			default_component_configs = {
				modified = {
					symbol = "●",
					highlight = "NeoTreeModified",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
				},
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeFileIcon",
					indent_marker = "│", -- Vertical line for indentation
					last_indent_marker = "╰", -- Symbol for the last item in a nested group
				},
				diagnostics = {
					symbols = {
						hint = "",
						info = "",
						warn = "",
						error = "",
					},
					highlights = {
						hint = "DiagnosticSignHint",
						info = "DiagnosticSignInfo",
						warn = "DiagnosticSignWarn",
						error = "DiagnosticSignError",
					},
				},
			},
		})
	end,
}
