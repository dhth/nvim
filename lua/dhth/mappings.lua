--- inserts a date using external command completion
vim.api.nvim_set_keymap(
    'n',
    '<Leader>da',
    [[idate +%Y-%m-%d!!bash<CR>]],
    {
        noremap = true,
        silent = true,
    }
)
