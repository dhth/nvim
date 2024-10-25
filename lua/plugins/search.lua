local telescope = require "telescope"

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                -- This will not install any breaking changes.
                -- For major updates, this must be adjusted manually.
                version = "^1.0.0",
            },
        },
        opts = {
            defaults = {
                cache_picker = {
                    num_pickers = 5,
                    limit_entries = 50,
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "> ",
                selection_caret = "> ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "descending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        mirror = false,
                    },
                    vertical = {
                        mirror = false,
                    },
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = {},
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                winblend = 0,
                border = {},
                color_devicons = true,
                use_less = true,
                path_display = {},
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            },
        },

        config = function(_, opts)
            local telescope_custom = require "custom.telescope"
            local lga_actions = require "telescope-live-grep-args.actions"

            opts.extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                },
                live_grep_args = {
                    auto_quoting = false, -- enable/disable auto-quoting
                    mappings = { -- extend mappings
                        i = {
                            ["<C-g>"] = lga_actions.quote_prompt {
                                postfix = " --iglob ",
                            },
                        },
                    },
                },
            }

            telescope.setup { opts }
            telescope.load_extension "live_grep_args"
            telescope.load_extension "fzf"

            local map_opts = { noremap = true, silent = true }

            REMAP("n", "<leader>re", function()
                require("telescope.builtin").resume()
            end, map_opts)
            REMAP("n", "<C-b>", function()
                require("telescope.builtin").buffers(
                    require("telescope.themes").get_ivy {
                        prompt_title = "~ buffers ~",
                        previewer = false,
                        results_title = false,
                        layout_config = { height = 0.6 },
                    }
                )
            end, map_opts)
            REMAP("n", "<C-s>", function()
                require("telescope.builtin").current_buffer_fuzzy_find {
                    previewer = false,
                    prompt_title = "search",
                    sorting_strategy = "ascending",
                    layout_config = { prompt_position = "top" },
                }
            end, map_opts)
            REMAP("n", "<leader>gb", function()
                require("telescope.builtin").git_branches()
            end, map_opts)
            REMAP("n", "<leader>ts", function()
                require("telescope.builtin").treesitter()
            end, map_opts)
            REMAP("n", "<leader>vh", function()
                require("telescope.builtin").help_tags()
            end, map_opts)
            REMAP("n", "<leader>sh", function()
                require("telescope.builtin").search_history(
                    require("telescope.themes").get_ivy {
                        results_title = false,
                        layout_config = { height = 0.6 },
                    }
                )
            end, map_opts)
            REMAP("n", "<C-g>", function()
                telescope.extensions.live_grep_args.live_grep_args(
                    require("telescope.themes").get_ivy {
                        prompt_title = "~ grep ~",
                        results_title = false,
                        preview_title = false,
                        cache_picker = { num_pickers = 5, limit_entries = 50 },
                        additional_args = { "--hidden" },
                        layout_config = { height = 0.8 },
                    }
                )
            end, map_opts)
            REMAP("n", "<C-f>", function()
                require("telescope.builtin").find_files(
                    require("telescope.themes").get_ivy {
                        find_command = { "fd", "-ipH", "-t=f", "-t=l" }, -- l=symlinks
                        prompt_title = "~ search files ~",
                        results_title = false,
                        previewer = false,
                        layout_config = { height = 0.6 },
                    }
                )
            end, map_opts)
            REMAP("n", "<leader>ii", function()
                require("telescope.builtin").lsp_implementations()
            end, map_opts)
            REMAP("n", "<leader>oo", function()
                vim.cmd "split"
                require("telescope.builtin").lsp_implementations()
            end, map_opts)
            REMAP("n", "<leader>ss", function()
                vim.cmd "Telescope persisted"
            end, map_opts)
            REMAP("n", "<leader>sm", function()
                telescope_custom.search_document_symbols()
            end, map_opts)
            REMAP("n", "<leader>sw", function()
                require("telescope.builtin").grep_string(
                    require("telescope.themes").get_ivy {
                        prompt_title = "~ grep ~",
                        results_title = false,
                        preview_title = false,
                        layout_config = { height = 0.8 },
                    }
                )
            end, map_opts)
            REMAP("n", "<leader>si", function()
                vim.cmd "Telescope lsp_implementations search=<c-r><c-w>"
            end, map_opts)

            -- custom
            REMAP("n", "<leader>w2", function()
                telescope_custom.search_work_wiki()
            end, map_opts)
            REMAP("n", "<leader>ww", function()
                telescope_custom.search_wiki()
            end, map_opts)
            REMAP("n", "<leader>tf", function()
                telescope_custom.find_test_files()
            end, map_opts)
            REMAP("n", "<leader>lo", function()
                telescope_custom.find_local_only_files()
            end, map_opts)
            REMAP("n", "<leader>sy", function()
                telescope_custom.find_docker_compose_files()
            end, map_opts)
            REMAP("n", "<leader>dkf", function()
                telescope_custom.find_dockerfiles()
            end, map_opts)
            REMAP("n", "<leader>te", function()
                telescope_custom.telescope_pickers()
            end, map_opts)
            REMAP("n", "<leader>vc", function()
                telescope_custom.grep_nvim()
            end, map_opts)
            REMAP("n", "<leader>cc", function()
                telescope_custom.edit_neovim()
            end, map_opts)
            REMAP("n", "<leader>lt", function()
                telescope_custom.search_linked_tests()
            end, map_opts)
            REMAP("n", "<leader>sf", function()
                telescope_custom.nearby_file_browser()
            end, map_opts)
            REMAP("n", "<leader>gd", function()
                telescope_custom.search_changed_files()
            end, map_opts)
            REMAP("n", "<leader>nf", function()
                telescope_custom.create_new_file_at_location()
            end, map_opts)
            REMAP("n", "<leader>rf", function()
                telescope_custom.search_related_files()
            end, map_opts)
            REMAP("n", "<leader>rr", function()
                telescope_custom.lsp_references()
            end, map_opts)
        end,
    },
    {
        "junegunn/fzf.vim",
        dependencies = {
            {
                "junegunn/fzf",
            },
        },
    },
}
