-- 2. Global Configuration
local spinners = { "◜", "◠", "◝", "◞", "◡", "◟" }
local progress_cache = {}

-- 3. LSP Progress Handler
local snacks = require("snacks.notifier")

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local token = result.token
    local progress = result.value

    -- Get server name with fallback
    local server_name = client and client.name or "LSP Server"

    -- Initialize token cache if needed
    progress_cache[token] = progress_cache[token] or {
        spinner_idx = 0,
        title = nil, -- Track LSP title from begin event
    }

    -- Track LSP title and spinner state
    if progress.kind == "begin" then
        progress_cache[token].title = progress.title
        progress_cache[token].spinner_idx = 0
    elseif progress.kind == "report" then
        progress_cache[token].spinner_idx = (progress_cache[token].spinner_idx + 1) % #spinners
    end

    -- Get current state from cache
    local cached = progress_cache[token]
    local spinner = spinners[cached.spinner_idx + 1] or " "
    local percentage = progress.percentage or 0
    local message = progress.message or ""
    local lsp_title = cached.title

    -- Handle completion
    if progress.kind == "end" or percentage >= 100 then
        spinner = "✓ "
        percentage = 100

        -- Schedule cleanup after 2 seconds
        vim.defer_fn(function()
            snacks.hide(token)
            progress_cache[token] = nil
        end, 2000)
    end

    -- Build message components
    local components = {
        spinner,
        "[" .. server_name .. "]",
        lsp_title, -- LSP's provided title
    }

    -- Add message if present
    if message ~= "" then
        table.insert(components, message)
    end

    -- Add percentage last
    table.insert(components, "(" .. percentage .. "%)")

    -- Format message content
    local message_content = table.concat(components, " ")

    -- Show notification with fixed title
    snacks.notify(message_content, vim.log.levels.INFO, {
        id = token,
        timeout = false,
        title = "LSP Progress Status",
    })
end
