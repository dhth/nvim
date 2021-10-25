require("harpoon").setup()

vim.api.nvim_set_keymap(
    'n',
    '<Leader>ha',
    [[<Cmd>:lua require("harpoon.mark").add_file()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)

vim.api.nvim_set_keymap(
    'n',
    '<Leader>hq',
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
