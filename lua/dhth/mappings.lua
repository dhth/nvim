-- local function REMAP(...) vim.api.nvim_set_keymap(...) end
local opts = { noremap = true, silent = true }

--- inserts a date using external command completion
REMAP(
    'n',
    '<Leader>da',
    [[idate +%Y-%m-%d!!bash<CR>]],
    opts
)

REMAP(
    'n',
    '<Leader>vn',
    ':vnew | setlocal buftype=nofile | setlocal nobuflisted<CR>',
    opts
)

REMAP(
    'n',
    '<Leader>vs',
    ':vsplit<CR>',
    opts
)

--- open plugins file
REMAP(
    'n',
    '<Leader>pg',
    ':new ~/.config/nvim/vim-plug/plugins.vim<CR>',
    opts
)

--- open plugins file
REMAP(
    'n',
    '<bs>',
    '<C-^>',
    opts
)

--- <ALT+o>
REMAP(
    'i',
    'ø',
    '<C-o>o',
    opts
)

--- <ALT+O>
REMAP(
    'i',
    'Ø',
    '<C-o>O',
    opts
)


--- Todo Telescope
REMAP(
    'n',
    '<Leader>td',
    ':TodoTelescope<CR>',
    opts
)

--- Substitute current word in current line
REMAP(
    'n',
    '<Leader>rw',
    ':s/<C-R><C-W>/',
    opts
)

--- Go to next test
REMAP(
    'n',
    '<Leader>nt',
    '<cmd>lua require("dhth.test_helpers").go_to_next_test()<CR>',
    opts
)

--- windo diffthis
REMAP(
    'n',
    '<Leader>dt',
    '<cmd>windo diffthis<CR>',
    opts
)

--- copen
REMAP(
    'n',
    '<Leader>co',
    '<cmd>copen<CR>',
    opts
)

--- git helpers
REMAP(
    'n',
    '<Leader>gh',
    '<cmd>lua require("dhth.git_helpers").git_commands()<CR>',
    opts
)

--- code helpers
REMAP(
    'n',
    '<Leader><Leader>',
    '<cmd>lua require("dhth.code_helpers").show_commands()<CR>',
    opts
)

--- code helpers
REMAP(
    'n',
    't<c-j>',
    '<cmd>lua require("dhth.code_helpers").show_commands()<CR>',
    opts
)

--- add todo comment
REMAP(
    'n',
    '<Leader>at',
    '<cmd>lua require("dhth.code_helpers").add_todo_comment()<CR>',
    opts
)

--- git push
REMAP(
    'n',
    '<Leader>gp',
    '<cmd>lua require("dhth.git_helpers").git_push()<CR>',
    opts
)


--- quit vim
REMAP(
    'n',
    '<Leader>vq',
    '<cmd>lua require("dhth.helpers").quit_vim()<CR>',
    opts
)

--- diffview open
REMAP(
    'n',
    '<Leader>do',
    ':DiffviewOpen origin/master..origin/',
    { noremap = false, silent = true }
)

-- move tab to the left
REMAP(
    'n',
    '---',
    ':tabclose<CR>',
    { noremap = false, silent = true }
)

-- go to last tab
REMAP(
    'n',
    '99',
    ':tablast<CR>',
    { noremap = false, silent = true }
)

--- run line as command
REMAP(
    'n',
    '<Leader>ru',
    '<cmd>lua require("dhth.code_helpers").run_line_as_command()<CR>',
    opts
)

--- diff file with main branch
REMAP(
    'n',
    '<Leader>dm',
    '<cmd>lua require("dhth.git_helpers").diff_with_main_branch()<CR>',
    opts
)

--- format buffer using lsp
REMAP(
    'n',
    'f<c-f>',
    '<cmd>lua vim.lsp.buf.format({async=true}) print("formatted 🧹")<CR>',
    opts
)

--- grep projects
REMAP(
    'n',
    'g<c-g>',
    '<cmd>lua require("dhth.telescope").grep_projects()<CR>',
    opts
)

--- search projects
REMAP(
    'n',
    '<leader>sp',
    '<cmd>lua require("dhth.telescope").search_projects()<CR>',
    opts
)

--- LCD to dir
REMAP(
    'n',
    '<leader>pp',
    '<cmd>lua require("dhth.telescope").lcd_to_dir()<CR>',
    opts
)

--- Code outline
REMAP(
    'n',
    '<leader>co',
    '<cmd>AerialToggle<CR>',
    opts
)

--- Yank non whitespace on line
REMAP(
    'n',
    'Y',
    'mQ^yg_`Q', -- ^ and g_ for skipping whitespace
    opts
)

--- Yank entire file contents
REMAP(
    'n',
    '<leader>fy',
    'mQggyG`Q',
    opts
)

--- Run visual selection via shell
REMAP(
    'v',
    'r<c-r>',
    "y<cmd>lua require('dhth.helpers').run_shell_command()<CR>",
    opts
)

--- Run inner paragraph via shell
REMAP(
    'n',
    'r<c-r>',
    "vipyOPgv:'<,'>!bash<CR>",
    opts
)

--- Run visual selection in terminal
REMAP(
    'v',
    '<c-t>',
    "y<cmd>lua require('dhth.helpers').replace_visual_selection_with_clipboard_after_command()<CR>",
    opts
)

--- Run inner paragraph in terminal
REMAP(
    'n',
    '<leader>rt',
    "<cmd>lua require('dhth.helpers').run_in_terminal({yank_first=true})<CR>",
    opts
)

--- Keep terminal open
REMAP(
    't',
    '<C-x>',
    '<C-\\><C-n>',
    opts
)

--- UndotreeToggle
REMAP(
    'n',
    '<leader>uu',
    "<cmd>UndotreeToggle<CR>",
    opts
)

--- Tab close
REMAP(
    'n',
    '<c-x>',
    "<cmd>tabclose<CR>",
    opts
)

--- Open dir in explorer
REMAP(
    'n',
    '<leader>dw',
    "<cmd>lua require('dhth.telescope').open_dir_in_explorer()<CR>",
    opts
)

--- D2 code to file
REMAP(
    'i',
    '[p',
    "<cmd>lua require('dhth.helpers').echo_buffer_path()<CR>",
    opts
)

--- substitute for visual mode
REMAP(
    'v',
    '<C-s>',
    ":s/",
    opts
)

--- cmds
REMAP(
    'n',
    ';;',
    "<cmd>lua require('dhth.helpers.tmux').cmds()<CR>",
    opts
)

--- .quickrun
REMAP(
    'n',
    ';`',
    "<cmd>lua require('dhth.helpers').run_quickrun()<CR>",
    opts
)

--- quickrun(1)
REMAP(
    'n',
    'e<c-e>',
    "<cmd>lua require('dhth.helpers.tmux').quickrun(1)<CR>",
    opts
)

--- quickrun 1-4
for i = 1, 4 do
    vim.api.nvim_set_keymap(
        'n',
        ";" .. i,
        "<cmd>lua require('dhth.helpers.tmux').quickrun(" .. i .. ")<CR>",
        opts
    )
end

--- copilot
REMAP(
    'v',
    '<c-e>',
    ":CopilotChatExplain<CR>",
    opts
)

--- diff file
REMAP(
    'n',
    '<leader>df',
    "<cmd>lua require('dhth.git_helpers').diff_file()<CR>",
    opts
)

--- show commit
REMAP(
    'n',
    '<leader>hd',
    ":DiffviewOpen HEAD~1..HEAD<CR>",
    opts
)

--- copilot toggle
REMAP(
    'n',
    '<c-p>',
    ":CopilotChatToggle<CR>",
    opts
)

--- autocomplete toggle
REMAP(
    'n',
    '<leader>ac',
    ":CmpToggle<CR>",
    opts
)
