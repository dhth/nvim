return {
    {
        "tpope/vim-fugitive",
        config = function()
            local opts = { noremap = true, silent = true }

            REMAP("n", "<leader>gs", ":Git<CR>", opts)
            -- REMAP('n', '<leader>dm', ':Gvdiffsplit! origin/main:%<CR>', opts)
            REMAP("n", "<leader>gf", ":diffget //2<CR>", opts) -- used during merge conflicts
            REMAP("n", "<leader>gj", ":diffget //3<CR>", opts)
            REMAP("n", "<leader>ds", ":Gvdiffsplit! HEAD:%<CR>", opts)
            REMAP("n", "<leader>gb", ":GBrowse<CR>", opts)
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            local cb = require("diffview.config").diffview_callback

            require("diffview").setup {
                key_bindings = {
                    disable_defaults = true, -- Disable the default key bindings
                    -- The `view` bindings are active in the diff buffers, only when the current
                    -- tabpage is a Diffview.
                    view = {
                        ["<down>"] = cb "select_next_entry", -- Open the diff for the next file
                        ["<up>"] = cb "select_prev_entry", -- Open the diff for the previous file
                        ["gf"] = cb "goto_file", -- Open the file in a new split in previous tabpage
                        ["<C-w><C-f>"] = cb "goto_file_split", -- Open the file in a new split
                        ["<C-w>gf"] = cb "goto_file_tab", -- Open the file in a new tabpage
                        ["<leader>e"] = cb "focus_files", -- Bring focus to the files panel
                        ["<leader>b"] = cb "toggle_files", -- Toggle the files panel.
                    },
                    file_panel = {
                        ["j"] = cb "next_entry", -- Bring the cursor to the next file entry
                        ["<down>"] = cb "next_entry",
                        ["k"] = cb "prev_entry", -- Bring the cursor to the previous file entry.
                        ["<up>"] = cb "prev_entry",
                        ["<cr>"] = cb "select_entry", -- Open the diff for the selected entry.
                        ["o"] = cb "select_entry",
                        ["<2-LeftMouse>"] = cb "select_entry",
                        ["s"] = cb "toggle_stage_entry", -- Stage / unstage the selected entry.
                        ["S"] = cb "stage_all", -- Stage all entries.
                        ["U"] = cb "unstage_all", -- Unstage all entries.
                        ["X"] = cb "restore_entry", -- Restore entry to the state on the left side.
                        ["R"] = cb "refresh_files", -- Update stats and entries in the file list.
                        ["gf"] = cb "goto_file",
                        ["<C-w><C-f>"] = cb "goto_file_split",
                        ["<C-w>gf"] = cb "goto_file_tab",
                        ["i"] = cb "listing_style", -- Toggle between 'list' and 'tree' views
                        ["f"] = cb "toggle_flatten_dirs", -- Flatten empty subdirectories in tree listing style.
                        ["<leader>e"] = cb "focus_files",
                        ["<leader>b"] = cb "toggle_files",
                    },
                    file_history_panel = {
                        ["g!"] = cb "options", -- Open the option panel
                        ["<C-A-d>"] = cb "open_in_diffview", -- Open the entry under the cursor in a diffview
                        ["y"] = cb "copy_hash", -- Copy the commit hash of the entry under the cursor
                        ["zR"] = cb "open_all_folds",
                        ["zM"] = cb "close_all_folds",
                        ["j"] = cb "next_entry",
                        ["<down>"] = cb "next_entry",
                        ["k"] = cb "prev_entry",
                        ["<up>"] = cb "prev_entry",
                        ["<cr>"] = cb "select_entry",
                        ["o"] = cb "select_entry",
                        ["<2-LeftMouse>"] = cb "select_entry",
                        ["gf"] = cb "goto_file",
                        ["<C-w><C-f>"] = cb "goto_file_split",
                        ["<C-w>gf"] = cb "goto_file_tab",
                        ["<leader>e"] = cb "focus_files",
                        ["<leader>b"] = cb "toggle_files",
                    },
                },
            }

            NOREMAP_SILENT("n", "<Leader>fh", ":DiffviewFileHistory %<CR>")

            NOREMAP_SILENT(
                "n",
                "d<c-d>",
                ":DiffviewOpen --untracked-files=false<CR>"
            )

            --- show commit
            NOREMAP_SILENT("n", "<leader>hd", ":DiffviewOpen HEAD~1..HEAD<CR>")

            vim.api.nvim_create_user_command("Hd", function(_)
                vim.cmd [[DiffviewOpen HEAD~1..HEAD]]
            end, {})
        end,
    },
}
