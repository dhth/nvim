return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "css",
                    "elm",
                    "gleam",
                    "go",
                    "gotmpl",
                    "haskell",
                    "helm",
                    "json",
                    "lua",
                    "python",
                    "rust",
                    "scala",
                    "terraform",
                    "toml",
                    "typescript",
                    "yaml",
                },
                ignore_install = { "javascript", "html" },
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = {
                        "fugitive",
                        "html",
                        "javascript",
                        "markdown",
                        "vimdoc",
                    },
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
                        init_selection = "<c-n>",
                        node_incremental = "<c-n>",
                        scope_incremental = "`1",
                        node_decremental = "1`",
                    },
                },
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-treesitter.configs").setup {
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]v"] = "@function.outer",
                            ["]w"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]["] = "@function.outer",
                            ["]M"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[v"] = "@function.outer",
                            ["[w"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[]"] = "@function.outer",
                            ["[M"] = "@class.outer",
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = "none",
                        peek_definition_code = {
                            ["<leader>fd"] = "@function.outer",
                            ["<leader>cd"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>s8"] = "@parameter.inner",
                            ["<leader>s9"] = "@function.outer",
                        },
                        swap_previous = {
                            ["<leader>s7"] = "@parameter.inner",
                            ["<leader>s6"] = "@function.outer",
                        },
                    },
                },
            }
        end,
    },
    {
        "echasnovski/mini.indentscope",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            {
                mappings = {
                    goto_top = "[[",
                    goto_bottom = "]]",
                },
            },
        },
    },
}
