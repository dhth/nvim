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


vim.api.nvim_set_keymap(
    'n',
    '<Leader>vn',
    ':vnew<CR>',
    {
        noremap = true,
        silent = true,
    }
)

vim.api.nvim_set_keymap(
    'n',
    '<Leader>vs',
    ':vsplit<CR>',
    {
        noremap = true,
        silent = true,
    }
)
