return {
    {
        "ggandor/leap.nvim",
        event = "InsertEnter",
        config = function()
            vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
            vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
        end,
    },
}
