return {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
        require('crates').setup({
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
            completion = {
                crates = {
                    enabled = true,   -- disabled by default
                    max_results = 12, -- The maximum number of search results to display
                    min_chars = 1     -- The minimum number of charaters to type before completions begin appearing
                }
            },
            max_parallel_requests = 300,
            autoupdate_throttle = 50,
            text = {
                searching = "   Searching",
                loading = "   Loading",
                version = "   %s",
                prerelease = "   %s",
                yanked = "  󰰵 %s",
                nomatch = "   No match",
                upgrade = "   %s",
                error = "   Error fetching crate",
            },
            popup = {
                autofocus = true,
                hide_on_select = false,
                copy_register = '"',
                style = "minimal",
                border = "single",
                show_version_date = true,
                show_dependency_version = true,
                max_height = 30,
                min_width = 20,
                padding = 1,
                text = {
                    title = " %s",
                    pill_left = "",
                    pill_right = "",
                    description = "%s",
                    created_label = " created        ",
                    created = "%s",
                    updated_label = " updated        ",
                    updated = "%s",
                    downloads_label = " downloads      ",
                    downloads = "%s",
                    homepage_label = " homepage       ",
                    homepage = "%s",
                    repository_label = " repository     ",
                    repository = "%s",
                    documentation_label = " documentation  ",
                    documentation = "%s",
                    crates_io_label = "  crates.io      ",
                    crates_io = "%s",
                    lib_rs_label = " lib.rs         ",
                    lib_rs = "%s",
                    categories_label = " categories     ",
                    keywords_label = " keywords       ",
                    version = "  %s",
                    prerelease = " %s",
                    yanked = "󰰵  %s",
                    version_date = "  %s",
                    feature = "  %s",
                    enabled = " %s",
                    transitive = " %s",
                    normal_dependencies_title = " Dependencies",
                    build_dependencies_title = " Build dependencies",
                    dev_dependencies_title = " Dev dependencies",
                    dependency = "  %s",
                    optional = " %s",
                    dependency_version = "  %s",
                    loading = "  ",
                },
            }
        })
    end,
}
