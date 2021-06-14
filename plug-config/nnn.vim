" Disable default mappings
let g:nnn#set_default_mappings = 0

" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.6, 'height': 0.9, 'highlight': 'Debug' } }

let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

nnoremap <silent> <C-e> :NnnPicker %:p:h<CR>
