-- =================================================================
-- LSP Progress Handler - Shows 0-100% for all LSPs
-- Requires: Snacks.nvim with notifier enabled
-- =================================================================

local M = {}
local spinners = { "◜ ", "◠ ", "◝ ", "◞ ", "◡ ", "◟ " }
local progress_cache = {}

local function show_notification(content, id, is_end)
	if not Snacks or not Snacks.notifier then
		vim.notify(content, vim.log.levels.INFO, { title = "LSP Progress" })
		return
	end
	Snacks.notifier.notify(content, "info", {
		id = id,
		timeout = is_end and 1800 or true,
		title = "LSP Progress",
	})
end

local function extract_work_progress(message)
	if not message then
		return nil
	end
	local done, total = message:match("(%d+)/(%d+)")
	if done and total then
		return tonumber(done), tonumber(total)
	end
	done, total = message:match("(%d+) of (%d+)")
	if done and total then
		return tonumber(done), tonumber(total)
	end
	done, total = message:match("Processing file (%d+) of (%d+)")
	if done and total then
		return tonumber(done), tonumber(total)
	end
	local done_only = message:match("(%d+) items processed")
	if done_only then
		return tonumber(done_only), nil
	end
	return nil, nil
end

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

	if progress.kind == "begin" then
		progress_cache[token] = {
			spinner_idx = 1,
			title = progress.title or "",
			message = progress.message or "",
			percentage = 0,
			work_done = 0,
			total_work = 0,
			report_count = 0,
			start_time = vim.loop.hrtime(),
		}
		cache_entry = progress_cache[token]

		if progress.message then
			local done, total = extract_work_progress(progress.message)
			if done and total then
				cache_entry.work_done = done
				cache_entry.total_work = total
				cache_entry.percentage = (done / total) * 100
			end
		end
	elseif not cache_entry then
		return
	end

	if progress.kind == "report" then
		cache_entry.spinner_idx = (cache_entry.spinner_idx % #spinners) + 1
		cache_entry.report_count = (cache_entry.report_count or 0) + 1

		if progress.message then
			cache_entry.message = progress.message
			local done, total = extract_work_progress(progress.message)
			if done then
				cache_entry.work_done = done
				if total then
					cache_entry.total_work = total
				end
				if cache_entry.total_work and cache_entry.total_work > 0 then
					cache_entry.percentage = math.min((cache_entry.work_done / cache_entry.total_work) * 100, 100)
				end
			end
		end

		if progress.percentage then
			cache_entry.percentage = progress.percentage
		else
			local report_progress = math.min(cache_entry.report_count * 5, 50)
			local elapsed_ms = (vim.loop.hrtime() - cache_entry.start_time) / 1000000
			local time_progress = math.min(elapsed_ms / 600, 50)
			cache_entry.percentage = math.min(report_progress + time_progress, 99)
		end
	end

	if progress.kind == "end" then
		cache_entry.spinner_idx = 1
		cache_entry.message = progress.message or cache_entry.message
		cache_entry.percentage = 100

		if cache_entry.total_work and cache_entry.total_work > 0 then
			cache_entry.work_done = cache_entry.total_work
		end
	end

	local notification_id = "lsp_progress_" .. tostring(token)
	local spinner = progress.kind == "end" and "✓ " or (spinners[cache_entry.spinner_idx] or " ")
	local percentage = cache_entry.percentage or 0
	local message = cache_entry.message
	local lsp_title = cache_entry.title

	local components = { spinner, "[" .. server_name .. "]" }

	if lsp_title and lsp_title ~= "" then
		table.insert(components, lsp_title)
	end

	if cache_entry.total_work and cache_entry.total_work > 0 then
		table.insert(components, string.format("%d/%d", cache_entry.work_done, cache_entry.total_work))
	elseif message and message ~= "" then
		table.insert(components, message)
	end

	table.insert(components, string.format("(%.0f%%)", percentage))

	local message_content = table.concat(components, " ")

	if progress.kind == "end" then
		show_notification(message_content, notification_id, true)
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
					if timer and not timer:is_closing() then
						timer:close()
					end
				end)
			)
		end
	else
		show_notification(message_content, notification_id, false)
	end
end

function M.cleanup()
	progress_cache = {}
end

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = M.cleanup,
})

return M
