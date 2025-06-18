return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- local current_hour = os.date("*t").hour
            -- if current_hour >= 10 and current_hour < 18 then
            --     vim.o.background = "light"
            -- else
            --     vim.o.background = "dark"
            -- end
            vim.o.background = "dark"
            require("gruvbox").setup {
                contrast = "", -- can be "hard", "soft" or empty string
            }
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
