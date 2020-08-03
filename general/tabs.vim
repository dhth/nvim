noremap <leader>tt :tabnew<CR>
noremap <leader>te :tabedit<space>
noremap <leader>tc :tabclose<CR>

"don't show tab line
"set showtabline=1

"move to next tab
noremap <leader>m gt
noremap <leader>n gT
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :tabnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :tabprevious<CR>
