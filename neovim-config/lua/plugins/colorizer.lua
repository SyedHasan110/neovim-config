return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = { -- set to setup table
	},
	config = function()
		require("colorizer").setup({
			user_default_options = {
				virtualtext = "",
				virtualtext_inline = "before",
				mode = "virtualtext",
			}
		})
	end
}
