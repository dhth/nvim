vim.api.nvim_set_keymap(
    'n',
    '<Leader>rt',
    [[<Cmd>:lua require("dhth.docker_test_runner").run_tests()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)
