local spinners = { "◜ ", "◠ ", "◝ ", "◞ ", "◡ ", "◟ " }
local progress_cache = {}

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	local token = result.token
	local progress = result.value
	local server_name = client and client.name or "LSP Server"

	-- Initialize token cache if needed
	progress_cache[token] = progress_cache[token] or {
		spinner_idx = 0,
		title = nil,
	}
	-- Track LSP title and spinner state
	if progress.kind == "begin" then
		progress_cache[token].title = progress.title
		progress_cache[token].spinner_idx = 0
	elseif progress.kind == "report" then
		progress_cache[token].spinner_idx = (progress_cache[token].spinner_idx + 1) % #spinners
	end

	local cached = progress_cache[token]
	local spinner = spinners[cached.spinner_idx + 1] or " "
	local percentage = progress.percentage or 0
	local message = progress.message or ""
	local lsp_title = cached.title

	-- Handle completion
	if progress.kind == "end" or percentage >= 100 then
		spinner = "✓ "
		percentage = 100
		-- Cleanup after 3.5 seconds (async)
		vim.defer_fn(function()
			Snacks.notifier.hide(token)
			progress_cache[token] = nil
		end, 2000)
	end

	-- Build message components
	local components = {
		spinner,
		"[" .. server_name .. "]",
		lsp_title,
	}

	if message ~= "" then
		table.insert(components, message)
	end

	table.insert(components, "(" .. percentage .. "%)")

	local message_content = table.concat(components, " ")
	-- Show notification (async via Snacks)
	Snacks.notifier.notify(message_content, "info", {
		id = token,
		timeout = true,
		title = "LSP Progress Status",
	})
end
