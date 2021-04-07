let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1


" Jump though hunks
" nnoremap ]c <plug>(signify-next-hunk)
" nnoremap [c <plug>(signify-prev-hunk)

nnoremap <leader>ggt :SignifyToggle<CR>
nnoremap <leader>ggl :SignifyToggleHighlight<CR>
nnoremap <leader>su :SignifyHunkUndo<CR>
nnoremap <leader>sd :SignifyHunkDiff<CR>
