"from https://www.youtube.com/watch?v=-I1b8BINyEw
nnoremap <C-p> :GFiles<CR>

"for FZF files
nnoremap <C-f> :Files<CR>

nnoremap <Leader>ps :Rg<SPACE>
nnoremap <Leader>bs :Lines<CR>
nnoremap <C-h> :History<CR>
nnoremap <leader>bl :BLines<CR>

"repeat same mappings for new tab
nnoremap <Leader><C-p> :tabnew<CR>:GFiles<CR>
nnoremap <Leader><C-f> :tabnew<CR>:Files<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif

let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
