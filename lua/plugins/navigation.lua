return {
    {
        "mcchrish/nnn.vim",
        init = function()
            vim.cmd [[
" Disable default mappings
let g:nnn#set_default_mappings = 0

" Floating window (neovim latest and vim with patch 8.2.191)
" let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }
let g:nnn#layout = 'vnew'
" let g:nnn#explorer_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }

let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

nnoremap <silent> <C-e> :NnnPicker %:p:h<CR>

let g:nnn#command = 'VISUAL="vi -u NONE" nnn'

]]
        end,
    },
}
