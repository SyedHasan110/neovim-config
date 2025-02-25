-- ~/.config/nvim/lua/custom/terminal.lua
local M = {}

-- Configuration defaults
local config = {
    toggle_key = "<leader>tt",
    shell = vim.o.shell,
    width = 0.8,
    height = 0.7,
    border = "rounded",
    title = " Terminal ",
    title_pos = "center",
    esc_close = true,
}

local state = {
    win_id = nil,
    buf_id = nil,
    ns_id = vim.api.nvim_create_namespace("FloatingTerminal")
}


-- Window calculations
local function get_dimensions()
    local width = math.floor(vim.o.columns * config.width)
    local height = math.floor(vim.o.lines * config.height)
    return {
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2)
    }
end

-- Terminal keymaps
local function set_keymaps(buf)
    if config.esc_close then
        vim.keymap.set("t", "<Esc>", "<C-\\><C-n><cmd>lua require('terminal').toggle()<CR>",
            { buffer = buf, desc = "Close terminal" })

        vim.keymap.set("n", "<Esc>", "<cmd>lua require('terminal').toggle()<CR>",
            { buffer = buf, desc = "Close terminal" })
    end
end

function M.toggle()
    if state.win_id and vim.api.nvim_win_is_valid(state.win_id) then
        vim.api.nvim_win_close(state.win_id, true)
        state.win_id = nil
        return
    end

    if not state.buf_id or not vim.api.nvim_buf_is_valid(state.buf_id) then
        state.buf_id = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_call(state.buf_id, function()
            vim.fn.termopen(config.shell)
        end)
        set_keymaps(state.buf_id)
    end

    local dim = get_dimensions()
    state.win_id = vim.api.nvim_open_win(state.buf_id, true, {
        title = config.title,
        title_pos = config.title_pos,
        border = config.border,
        style = "minimal",
        relative = "editor",
        width = dim.width,
        height = dim.height,
        row = dim.row,
        col = dim.col,
        noautocmd = true,
    })
    vim.cmd("startinsert")
end

function M.setup(user_config)
    config = vim.tbl_deep_extend("force", config, user_config or {})
    vim.keymap.set("n", config.toggle_key, M.toggle, { desc = "Toggle floating terminal" })
end

return M
