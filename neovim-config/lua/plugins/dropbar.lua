return {
    {
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        config = function()
            require("dropbar").setup({
                bar = {
                    padding = {
                        left = 2,
                        right = 2
                    }
                },
                icons = {
                    kinds = {
                        symbols = {
                            Array = ' ',
                            Boolean = ' ',
                            BreakStatement = '󰙧 ',
                            Call = '󰃷 ',
                            CaseStatement = '󱃙 ',
                            Class = ' ',
                            Color = ' ',
                            Constant = ' ',
                            Constructor = ' ',
                            ContinueStatement = '→ ',
                            Copilot = ' ',
                            Declaration = '󰙠 ',
                            Delete = ' ',
                            DoStatement = '󰑖 ',
                            Enum = ' ',
                            EnumMember = ' ',
                            Event = ' ',
                            Field = ' ',
                            File = ' ',
                            Folder = ' ',
                            ForStatement = '󰑖 ',
                            Function = ' ',
                            H1Marker = '󰉫 ', -- Used by markdown treesitter parser
                            H2Marker = '󰉬 ',
                            H3Marker = '󰉭 ',
                            H4Marker = '󰉮 ',
                            H5Marker = '󰉯 ',
                            H6Marker = '󰉰 ',
                            Identifier = '󰻾 ',
                            IfStatement = '󰇉 ',
                            Interface = ' ',
                            Keyword = ' ',
                            List = ' ',
                            Log = ' ',
                            Lsp = ' ',
                            Macro = ' ',
                            MarkdownH1 = '󰉫 ', -- Used by builtin markdown source
                            MarkdownH2 = '󰉬 ',
                            MarkdownH3 = '󰉭 ',
                            MarkdownH4 = '󰉮 ',
                            MarkdownH5 = '󰉯 ',
                            MarkdownH6 = '󰉰 ',
                            Method = '󰆧 ',
                            Module = '󰏗 ',
                            Namespace = ' ',
                            Null = '󰢤 ',
                            Number = ' ',
                            Object = ' ',
                            Operator = ' ',
                            Package = ' ',
                            Pair = ' ',
                            Property = ' ',
                            Reference = ' ',
                            Regex = ' ',
                            Repeat = '󰑖 ',
                            Scope = ' ',
                            Snippet = ' ',
                            Specifier = '󰦪 ',
                            Statement = ' ',
                            String = ' ',
                            Struct = ' ',
                            SwitchStatement = '󰺟 ',
                            Table = ' ',
                            Terminal = ' ',
                            Text = ' ',
                            Type = ' ',
                            TypeParameter = '󰆩 ',
                            Unit = ' ',
                            Value = '󰎠 ',
                            Variable = ' ',
                            WhileStatement = '󰑖 ',
                        }
                    }
                }
            })
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end
    }
}
