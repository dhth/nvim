" nnoremap <leader>tt :tabnew<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <leader>te :tabedit<space>
nnoremap <silent> <leader>tc :tabclose<CR>

"don't show tab line
"set showtabline=1

"move to next tab
" nnoremap <leader>m gt
" nnoremap <leader>n gT
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>

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
