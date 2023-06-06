require("harpoon").setup({
    menu = {
        width = math.floor(vim.api.nvim_win_get_width(0) * .6 ),
    }
})

vim.api.nvim_set_keymap(
    'n',
    '``',
    [[<Cmd>:lua require("harpoon.mark").add_file()<CR>:echo "Added!"<CR>]],
    {
        noremap = true,
        silent = true,
    }
)

vim.api.nvim_set_keymap(
    'n',
    ';;',
    [[<Cmd>:lua require("harpoon.ui").toggle_quick_menu()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)


for i=1,9 do
    vim.api.nvim_set_keymap(
        'n',
        '<Leader>' .. i,
        "<cmd>:lua require(\"harpoon.ui\").nav_file(" .. i .. ")<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
end
