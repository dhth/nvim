highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
" let g:bookmark_sign = '?'
let g:bookmark_annotation_sign = '?'
" let g:bookmark_highlight_lines = 1
" let g:bookmark_save_per_working_dir = 1
let g:bookmark_manage_per_buffer = 1
" let g:bookmark_auto_save = 1

" nnoremap <silent> <Leader>ba <Plug>BookmarkToggle
" nnoremap <silent> <Leader>ba <Plug>BookmarkAnnotate
" nnoremap <silent> <Leader>bl <Plug>BookmarkShowAll
nnoremap <Leader>ba :BookmarkAnnotate<CR>
" nnoremap <silent> <Leader>bl :BookmarkShowAll<CR>
" nnoremap <silent> <Leader>j <Plug>BookmarkNext
" nnoremap <silent> <Leader>k <Plug>BookmarkPrev
" nnoremap <silent> <Leader>c <Plug>BookmarkClear
" nnoremap <silent> <Leader>x <Plug>BookmarkClearAll
" nnoremap <silent> <Leader>kk <Plug>BookmarkMoveUp
" nnoremap <silent> <Leader>jj <Plug>BookmarkMoveDown
" nnoremap <silent> <Leader>g <Plug>BookmarkMoveToLine
