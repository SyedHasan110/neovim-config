vim.keymap.set({ "n", "i", "c", "v" }, "<C-s>", "<cmd>w<CR>")
vim.keymap.set({ "n", "i", "v", "c" }, "<C-q>", "<cmd>qa<CR>")
vim.keymap.set({ "n", "v" }, "<leader>qb", "<cmd>BufferClose<CR>")
vim.keymap.set({ "n", "v" }, "<leader>qw", "<cmd>q<CR>")
vim.keymap.set("n", "<C-f>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<A-Up>", ":m-2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", ":m+<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-/>", "gcc", { remap = true })
vim.keymap.set("v", "<C-/>", "gc", { remap = true })
vim.keymap.set("i", "<C-/>", function()
	vim.cmd("normal gcc")
end, { remap = true })
vim.keymap.set({ "n", "v", "i" }, "<A-Right>", function()
	vim.cmd("bnext")
end)
vim.keymap.set({ "n", "v", "i" }, "<A-Left>", function()
	vim.cmd("bprevious")
end)

-- A simple script to toggle a fiveserver live-reload instance for the
-- current project directory.

-- We use a local variable to keep track of the running fiveserver process ID.
local job_id = nil
local fs_bin = require("fs.config").opts.bin
--- Toggles the fiveserver instance.
-- If a server is running, it stops it.
-- If no server is running, it starts one in the current working directory (cwd),
-- and opens the current buffer's file in the browser.
local function toggle()
	-- Check if the job_id is valid and points to a running process.
	if job_id and vim.fn.jobwait({ job_id }, 0)[1] == -1 then
		-- A job is running, so we need to stop it.
		vim.fn.jobstop(job_id)
		-- The on_exit callback will handle setting job_id to nil.
		vim.notify("FiveServer stopped.", vim.log.levels.INFO, { title = "FiveServer" })
	else
		-- No job is running, so we'll start one.
		local current_file = vim.fn.expand("%")
		if current_file == "" then
			vim.notify(
				"Cannot start: No file open in the current buffer.",
				vim.log.levels.WARN,
				{ title = "FiveServer" }
			)
			return
		end

		local cwd = vim.fn.getcwd()
		local cmd = { fs_bin, "--open=" .. current_file }

		-- Start the server as an asynchronous job.
		job_id = vim.fn.jobstart(cmd, {
			cwd = cwd,
			-- This callback ensures our state is cleaned up if the server crashes
			-- or is killed by any means (including our jobstop command).
			on_exit = function()
				job_id = nil
			end,
		})

		if job_id and job_id > 0 then
			vim.notify("FiveServer started for: " .. current_file, vim.log.levels.INFO, { title = "FiveServer" })
		else
			-- If job_id is 0 or -1, the command failed to start.
			job_id = nil -- Ensure state is clean on failure.
			vim.notify(
				"Failed to start FiveServer. Is it installed and in your PATH?",
				vim.log.levels.ERROR,
				{ title = "FiveServer" }
			)
		end
	end
end

-- Create a user-friendly command to call the toggle function.
vim.api.nvim_create_user_command("FiveServerToggle", toggle, {})

-- Set a keymap in normal mode to easily toggle the server.
-- You can change '<leader>fs' to any key combination you prefer.
vim.keymap.set("n", "<leader>fs", "<Cmd>FiveServerToggle<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle FiveServer",
})
