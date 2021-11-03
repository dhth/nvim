vim.cmd([[imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']])
vim.cmd([[imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']])
vim.cmd([[let g:vsnip_snippet_dir = expand('~/.config/nvim/snippets')]])

--- Mappings
local opts = { noremap=true, silent=true }

--- open snippets
REMAP(
    'n',
    '<Leader>sn',
    ':VsnipOpen<CR>',
    opts
)
