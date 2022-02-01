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


-- test results for current file
vim.api.nvim_set_keymap(
    'n',
    '<Leader>stc',
    [[<Cmd>:lua require("dhth.test_helpers").search_tests_for_current_file()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)
