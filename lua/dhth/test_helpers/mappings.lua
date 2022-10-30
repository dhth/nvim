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
    '<Leader>st',
    [[<Cmd>:lua require("dhth.test_helpers").search_tests_for_current_file()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)


-- run sbt compile
vim.api.nvim_set_keymap(
    'n',
    '<Leader>sc',
    [[<Cmd>:lua require("dhth.test_helpers.scala").run_sbt_compile()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)

-- sbt compile results
vim.api.nvim_set_keymap(
    'n',
    '<Leader>ce',
    [[<Cmd>:lua require("dhth.test_helpers.scala").compile_errors_to_quickfix()<CR>]],
    {
        noremap = true,
        silent = true,
    }
)
