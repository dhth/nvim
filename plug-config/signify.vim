let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1


" Jump though hunks
nmap ]c <plug>(signify-next-hunk)
nmap [c <plug>(signify-prev-hunk)

nmap <leader>ggt :SignifyToggle<CR>
nmap <leader>ggl :SignifyToggleHighlight<CR>
