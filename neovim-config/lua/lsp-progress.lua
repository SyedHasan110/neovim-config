-- =================================================================
-- Custom LSP Progress Handler
-- NOTE: This requires a notification plugin that provides `Snacks.notifier`.
-- =================================================================
local spinners = { "◜ ", "◠ ", "◝ ", "◞ ", "◡ ", "◟ " }
local progress_cache = {}

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	local token = result.token
	local progress = result.value
	local server_name = client and client.name or "LSP Server"

	local cache_entry = progress_cache[token]

	-- If a new task begins for a token that had a pending cleanup timer,
	-- cancel the old timer to prevent it from closing the new notification.
	if progress.kind == "begin" and cache_entry and cache_entry.cleanup_timer then
		vim.fn.timer_stop(cache_entry)
	end

	-- Initialize or reset the cache entry when a task starts.
	if progress.kind == "begin" then
		progress_cache[token] = {
			spinner_idx = 1, -- Start at the first spinner
			title = progress.title,
			cleanup_timer = nil,
		}
		cache_entry = progress_cache[token]
	-- A 'report' or 'end' should not happen without a 'begin', but we check to be safe.
	elseif not cache_entry then
		return
	end

	-- Update spinner state on 'report'.
	if progress.kind == "report" then
		cache_entry.spinner_idx = (cache_entry.spinner_idx % #spinners) + 1
	end

	local spinner = spinners[cache_entry.spinner_idx] or " "
	local percentage = progress.percentage
	local message = progress.message
	local lsp_title = cache_entry.title

	-- Handle completion state.
	if progress.kind == "end" then
		spinner = "✓ "
		-- For display purposes, show 100% on completion if no percentage is given.
		if percentage == nil then
			percentage = 100
		end

		-- Schedule the cleanup and store the timer ID so we can cancel it if needed.
		cache_entry.cleanup_timer = vim.defer_fn(function()
			if Snacks and Snacks.notifier and Snacks.notifier.hide then
				Snacks.notifier.hide(token)
			end
			progress_cache[token] = nil
		end, 1800)
	end

	-- Safely build message components, only including parts that exist.
	local components = { spinner, "[" .. server_name .. "]" }
	if lsp_title and lsp_title ~= "" then
		table.insert(components, lsp_title)
	end
	if message and message ~= "" then
		table.insert(components, message)
	end
	if percentage then
		table.insert(components, string.format("(%.0f%%)", percentage))
	end

	local message_content = table.concat(components, " ")

	Snacks.notifier.notify(message_content, "info", {
		id = token,
		timeout = true, -- Let the notifier handle the timeout
		title = "LSP Progress",
	})
end
