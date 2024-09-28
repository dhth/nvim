-- require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

require 'nvim-treesitter.configs'.setup {
    -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "go", "rust", "python", "scala", "lua", "json", "yaml", "toml", "css" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { "javascript", "html" },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "vimdoc", "html", "javascript", "fugitive", "markdown" }
        -- use the function below to determine languages to disable TS for
        -- TS's internal language names may differ from vim's file type
        -- disable = function(lang, _)
        --     if lang == "vimdoc" then
        --         return true
        --     end
        --     return false
        -- end,
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "``",
            node_incremental = "``",
            scope_incremental = "`1",
            node_decremental = "1`",
        },
    },
}
