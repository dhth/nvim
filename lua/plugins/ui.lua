return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            attach_to_untracked = false,
            on_attach = function(bufnr)
                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend(
                        "force",
                        { noremap = true, silent = true },
                        opts or {}
                    )
                    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                end

                -- Navigation
                map(
                    "n",
                    "]c",
                    "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
                    { expr = true }
                )
                map(
                    "n",
                    "[c",
                    "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
                    { expr = true }
                )

                -- Actions
                map("n", "<leader>rh", ":Gitsigns reset_hunk<CR>")
                map("n", "<leader>dh", "<cmd>Gitsigns preview_hunk_inline<CR>")
                -- map('n', '<leader>df', '<cmd>Gitsigns diffthis<CR>')

                -- Text object
                map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
                map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        config = function()
            require("barbar").setup {
                animation = false,
                auto_hide = false,
                tabpages = true,
                clickable = false,
                icons = {
                    buffer_index = true,
                    button = false,
                },
                semantic_letters = false,
            }

            NOREMAP_SILENT(
                "n",
                "<leader>bo",
                "<Cmd>BufferCloseAllButCurrent<CR>"
            )
            NOREMAP_SILENT("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>")
            NOREMAP_SILENT("n", "<Tab>", "<Cmd>BufferNext<CR>")
            NOREMAP_SILENT("n", "<<", "<Cmd>BufferMovePrevious<CR>")
            NOREMAP_SILENT("n", ">>", "<Cmd>BufferMoveNext<CR>")
            NOREMAP_SILENT("n", "<A-p>", "<Cmd>BufferPin<CR>")
            NOREMAP_SILENT("n", "<leader>xx", "<Cmd>BufferClose<CR>")
            NOREMAP_SILENT("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>")
            NOREMAP_SILENT("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>")
            NOREMAP_SILENT(
                "n",
                "<Space>bw",
                "<Cmd>BufferOrderByWindowNumber<CR>"
            )

            for i = 1, 9 do
                NOREMAP_SILENT("n", "<leader>" .. i,
                    "<Cmd>BufferGoto " .. i .. "<CR>")
            end
            -- https://github.com/romgrk/barbar.nvim?tab=readme-ov-file#highlighting
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "gruvbox",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {},
                lualine_c = { { "filename", path = 4 } },
                lualine_x = {},
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
}
