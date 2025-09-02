return {
	"Diogo-ss/five-server.nvim",
	cmd = { "FiveServer" },
	build = function()
		require("fs.utils.install")()
	end,
	opts = {
		notify = true,
		-- add other options
	},
	config = function(_, opts)
		require("fs").setup(opts)
		local mason_registry = require("mason-registry")
		mason_registry.refresh(function()
			local check_fiveserver =
				require("fs.utils.process").get_path_instance(vim.fn.stdpath("data") .. "/five-server")
			if check_fiveserver == nil then
				vim.cmd("FiveServer install")
			end
		end)
	end,
}
