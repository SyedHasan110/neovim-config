return {
	"Diogo-ss/five-server.nvim",
	cmd = { "FiveServer" },
	build = function()
		require("fs.utils.install")()
	end,
	config = function(_)
		require("fs").setup({
			notify = true,
		})
	end,
}
