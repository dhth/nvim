-- local function REMAP(...) vim.api.nvim_set_keymap(...) end
local opts = { noremap=true, silent=true }

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
    ':vnew<CR>',
    opts
)

REMAP(
    'n',
    '<Leader>vs',
    ':vsplit<CR>',
    opts
)

--- create a scratch buffer
REMAP(
    'n',
    '<Leader>sc',
    '<cmd>lua require("dhth.helpers").new_scratch_buffer()<CR>',
    opts
)

--- go to last buffer
REMAP(
    'n',
    '<Leader>6',
    '<C-^>',
    opts
)

--- open plugins file
REMAP(
    'n',
    '<Leader>pg',
    ':tabnew ~/.config/nvim/vim-plug/plugins.vim<CR>',
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
    '<Leader>sl',
    ':s/<C-R><C-W>/',
    opts
)

--- Convert lines to markdown list
REMAP(
    'v',
    'ml',
    ":g/./norm!I - <cr>",
    opts
)

--- Convert lines to markdown bullet list
REMAP(
    'v',
    'mb',
    ":g/./norm!I - [ ] <cr>",
    opts
)

--- Go to tab at index
for i=1,9 do
    vim.api.nvim_set_keymap(
        'n',
        '<Leader>' .. i,
        i .. "gt",
        {
            noremap = true,
            silent = true,
        }
    )
end


--- LSP code formatting
REMAP(
    'n',
    '<Leader>fo',
    '<cmd>lua vim.lsp.buf.formatting()<CR>',
    opts
)
