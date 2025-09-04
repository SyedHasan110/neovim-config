-- =================================================================
-- Fixed LSP Progress Handler - Ensures Final Message Shows
-- Requires: Snacks.nvim with notifier enabled
-- =================================================================

local spinners = { "◜ ", "◠ ", "◝ ", "◞ ", "◡ ", "◟ " }
local progress_cache = {}

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if not client then
		return
	end

	local token = result.token
	local progress = result.value
	local server_name = client.name or "LSP Server"

	if not progress or not progress.kind then
		return
	end

	local cache_entry = progress_cache[token]

	-- Handle begin
	if progress.kind == "begin" then
		progress_cache[token] = {
			spinner_idx = 1,
			title = progress.title or "",
			message = progress.message or "",
			percentage = progress.percentage,
			work_done = 0,
			total_work = 0,
		}
		cache_entry = progress_cache[token]

		-- Extract work progress from message
		if progress.message then
			local done, total = progress.message:match("(%d+)/(%d+)")
			if done and total then
				cache_entry.work_done = tonumber(done)
				cache_entry.total_work = tonumber(total)
			end
		end
	elseif not cache_entry then
		return
	end

	-- Handle report
	if progress.kind == "report" then
		cache_entry.spinner_idx = (cache_entry.spinner_idx % #spinners) + 1

		-- Update work progress from message
		if progress.message then
			cache_entry.message = progress.message
			local done, total = progress.message:match("(%d+)/(%d+)")
			if done and total then
				cache_entry.work_done = tonumber(done)
				cache_entry.total_work = tonumber(total)
			end
		end

		if progress.percentage then
			cache_entry.percentage = progress.percentage
		end
	elseif progress.kind == "end" then
		cache_entry.spinner_idx = 1
		cache_entry.message = progress.message or cache_entry.message
		cache_entry.percentage = progress.percentage or 100

		-- Ensure work done equals total work on completion
		if cache_entry.total_work and cache_entry.total_work > 0 then
			cache_entry.work_done = cache_entry.total_work
		end
	end

	-- Create consistent notification ID
	local notification_id = "lsp_progress_" .. tostring(token)

	local spinner = progress.kind == "end" and "✓ " or (spinners[cache_entry.spinner_idx] or " ")
	local percentage = cache_entry.percentage
	local message = cache_entry.message
	local lsp_title = cache_entry.title

	-- Build message components
	local components = { spinner, "[" .. server_name .. "]" }

	if lsp_title and lsp_title ~= "" then
		table.insert(components, lsp_title)
	end

	-- Show work progress in message if available
	if cache_entry.total_work and cache_entry.total_work > 0 then
		table.insert(components, string.format("%d/%d", cache_entry.work_done, cache_entry.total_work))
	elseif message and message ~= "" then
		table.insert(components, message)
	end

	if percentage and progress.kind ~= "end" then
		table.insert(components, string.format("(%.0f%%)", percentage))
	end

	local message_content = table.concat(components, " ")

	if not Snacks or not Snacks.notifier then
		return
	end

	-- Handle completion with proper cleanup
	if progress.kind == "end" then
		-- Show final message immediately
		Snacks.notifier.notify(message_content, "info", {
			id = notification_id,
			timeout = 3000,
			title = "LSP Progress",
		})

		-- Schedule cleanup after showing the final message
		local timer = vim.uv.new_timer()
		if timer then
			timer:start(
				3100,
				0,
				vim.schedule_wrap(function()
					if Snacks and Snacks.notifier and Snacks.notifier.hide then
						Snacks.notifier.hide(notification_id)
					end
					progress_cache[token] = nil
					if not timer:is_closing() then
						timer:close()
					end
				end)
			)
		end
	else
		-- Show/update ongoing progress
		Snacks.notifier.notify(message_content, "info", {
			id = notification_id,
			timeout = true,
			title = "LSP Progress",
		})
	end
end

-- Cleanup function
local function cleanup()
	progress_cache = {}
end

-- Cleanup on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = cleanup,
})
