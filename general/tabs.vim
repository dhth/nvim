" nnoremap <leader>tt :tabnew<CR>
nnoremap <C-t> :tabnew<CR>
" nnoremap <leader>te :tabedit<space>
nnoremap <silent> <leader>a; :tabclose<CR>

"don't show tab line
"set showtabline=1

"move to next tab
" nnoremap <leader>m gt
" nnoremap <leader>n gT
" nnoremap <leader>t1 1gt
" nnoremap <leader>t2 2gt
" nnoremap <leader>t3 3gt
" nnoremap <leader>t4 4gt
" nnoremap <leader>t5 5gt
" " nnoremap <leader>t6 6gt
" " leader 6 is being remapped to <C-^>
" nnoremap <leader>t7 7gt
" nnoremap <leader>t8 8gt
" nnoremap <leader>t9 9gt
nnoremap <leader>t0 :tablast<cr>

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :tabnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :tabprevious<CR>

" https://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nnoremap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
