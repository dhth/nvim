-- run tests
vim.api.nvim_set_keymap(
    'n',
    '<Leader>rt',
    [[<Cmd>:lua require("dhth.test_helpers").run_tests()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)

-- test results
vim.api.nvim_set_keymap(
    'n',
    '<Leader>tr',
    [[<Cmd>:lua require("dhth.test_helpers").failed_test_qf()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)
