local snacks = require("snacks.notifier")
local active_messages = {}
local spinner_frames = { '◜', '◠ ', '◝ ', '◞ ', '◡ ', '◟' }
local completion_icon = '✓ ' -- Completion indicator
local notification_id = nil
local minimum_display = 3 -- seconds

-- Parse fraction progress (e.g. "32/256")
local function parse_fraction(message)
    if not message then return nil end
    local done, total = message:match("(%d+)/(%d+)")
    if done and total then
        return math.floor((tonumber(done) / tonumber(total)) * 100)
    end
    return nil
end

-- Safe nested table access
local function safe_get(obj, ...)
    for _, key in ipairs({ ... }) do
        if not obj then return nil end
        obj = obj[key]
    end
    return obj
end

-- Format message with progress handling
local function format_message(msg)
    if not msg then return "" end

    local parts = {}

    if msg.completed then
        table.insert(parts, completion_icon)
    else
        local frame = msg.spinner_frame or 1
        table.insert(parts, spinner_frames[frame] or spinner_frames[1])
    end

    table.insert(parts, msg.client_name or "Unknown")
    table.insert(parts, msg.title or "Processing")

    -- Show either percentage or message (not both)
    if msg.display_percentage then
        table.insert(parts, string.format("(%d%%)", msg.display_percentage))
    elseif msg.message and msg.message ~= "" then
        table.insert(parts, msg.message)
    end

    return table.concat(parts, " ")
end

-- Update notification window
local function update_notification()
    if not active_messages then return end

    local lines = {}
    for _, msg in pairs(active_messages) do
        if msg then
            local line = format_message(msg)
            if line and line ~= "" then
                table.insert(lines, line)
            end
        end
    end

    if #lines == 0 then
        if notification_id then
            pcall(snacks.hide, notification_id)
            notification_id = nil
        end
        return
    end

    local success, new_id = pcall(snacks.notify,
        table.concat(lines, "\n"),
        'info',
        {
            id = notification_id,
            timeout = false,
            persistent = true,
            title = "LSP Progress Status",
            border = "single"
        }
    )

    if success then
        notification_id = new_id
    end
end

vim.lsp.handlers['$/progress'] = function(_, result, ctx, _)
    local client_id = safe_get(ctx, 'client_id')
    local token = safe_get(result, 'token')
    local value = safe_get(result, 'value')

    if not client_id or not token or not value then return end

    local client = vim.lsp.get_client_by_id(client_id)
    local client_name = client and client.name or "Unknown Client"
    local key = client_id .. "_" .. token

    local kind = safe_get(value, 'kind')

    if kind == 'begin' then
        active_messages[key] = {
            client_name = client_name,
            title = safe_get(value, 'title') or "Processing",
            message = safe_get(value, 'message'),
            percentage = 0,
            display_percentage = 0,
            spinner_frame = 1,
            completed = false,
            start_time = os.time(),
            visible = true -- Show immediately
        }
        update_notification()
    elseif kind == 'report' then
        if active_messages[key] then
            -- Convert fraction messages to percentage
            local fraction_percent = parse_fraction(safe_get(value, 'message'))
            if fraction_percent then
                active_messages[key].percentage = fraction_percent
                active_messages[key].display_percentage = fraction_percent
            else
                active_messages[key].message = safe_get(value, 'message')
            end
            update_notification()
        end
    elseif kind == 'end' then
        if active_messages[key] then
            active_messages[key].completed = true
            active_messages[key].percentage = 100
            active_messages[key].display_percentage = 100
            active_messages[key].end_time = os.time()
            update_notification()
        end
    end
end

-- Animation and cleanup timer
local timer = vim.uv.new_timer()
if timer then
    timer:start(0, 200, vim.schedule_wrap(function()
        if not active_messages then return end

        local now = os.time()
        local needs_update = false

        for key, msg in pairs(active_messages) do
            if msg then
                -- Animate spinner for active messages
                if not msg.completed then
                    msg.spinner_frame = ((msg.spinner_frame or 1) % #spinner_frames) + 1
                    needs_update = true
                end

                -- Animate percentage to 100% if completed
                if msg.completed and msg.display_percentage < 100 then
                    msg.display_percentage = math.min(msg.display_percentage + 5, 100)
                    needs_update = true
                end

                -- Cleanup completed messages after minimum display time
                if msg.completed and msg.end_time and (now - msg.end_time) >= minimum_display then
                    active_messages[key] = nil
                    needs_update = true
                end

                -- Auto-complete stuck messages after 30 seconds
                if not msg.completed and (now - msg.start_time) >= 30 then
                    msg.completed = true
                    msg.end_time = now
                    msg.display_percentage = 100
                    needs_update = true
                end
            end
        end

        if needs_update then
            pcall(update_notification)
        end
    end))
else
    vim.notify("LSP Progress: Failed to create timer", vim.log.levels.ERROR)
end
