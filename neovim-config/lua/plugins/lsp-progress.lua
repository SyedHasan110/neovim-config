return {
    'linrongbin16/lsp-progress.nvim',
    config = function()
        require('lsp-progress').setup({
            regular_internal_update_time = 200,
            decay = 100,
            spinner = { "◜ ", "◠ ", "◝ ", "◞ ", "◡ ", "◟" },
            format = function(client_messages)
                local api = require("lsp-progress.api")
                -- icon: nf-fa-gear \uf013
                local sign = " LSP"
                if #client_messages > 0 then
                    return sign .. " " .. table.concat(client_messages, " ")
                end
                if #api.lsp_clients() > 0 then
                    return sign
                end
                return ""
            end,
        })
    end

}
