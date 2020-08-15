noremap <leader>ml f]gf
noremap <ENTER> 0f]<C-W>gf
" augroup mdtoc
"     autocmd BufRead * Toc
" augroup END
" Open TOC and switch back to left window
" Toc
" wincmd h
nnoremap <leader>/ :Toc<CR>
nnoremap <leader>tf :TableFormat<CR>
nnoremap <leader>- o<esc>I- 
set tw=80
" set foldmethod=syntax
