return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "hard", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        },
        config = function()
            -- local current_hour = os.date("*t").hour
            -- if current_hour >= 10 and current_hour < 18 then
            --     vim.o.background = "light"
            -- else
            --     vim.o.background = "dark"
            -- end

            vim.o.background = "dark"
            vim.cmd [[colorscheme gruvbox]]

            vim.api.nvim_exec(
                [[
  hi DiffAdd      gui=none    guifg=#1F2F38          guibg=#84B97C
  hi DiffChange   gui=none    guifg=none             guibg=none
  hi DiffDelete   gui=bold    guifg=#1F2F38          guibg=#DC657D
  hi DiffText     gui=bold    guifg=#1F2F38          guibg=#D4B261
]],
                false
            )
        end,
    },
}
