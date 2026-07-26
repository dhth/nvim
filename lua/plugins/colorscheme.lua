return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local background_by_theme = {
                ["gruvbox-dark-hard"] = "dark",
                ["gruvbox-light-hard"] = "light",
            }
            local state_file = vim.fn.expand "~/.local/state/dotfiles/theme"
            local theme = "gruvbox-dark-hard"

            if vim.fn.filereadable(state_file) == 1 then
                theme = vim.fn.readfile(state_file, "", 1)[1] or theme
            end

            vim.o.background = background_by_theme[theme] or "dark"
            require("gruvbox").setup {
                contrast = "hard", -- can be "hard", "soft" or empty string
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
