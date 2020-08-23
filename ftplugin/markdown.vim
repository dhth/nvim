nnoremap <buffer> <leader>ml f]gf
" nnoremap <buffer> <ENTER> 0f]<C-W>gf
nnoremap <buffer> <silent> <ENTER> :call wiki#EnterKeyActions(getline('.'))<cr>
" augroup mdtoc
"     autocmd BufRead * Toc
" augroup END
" Open TOC and switch back to left window
" Toc
" wincmd h
noremap <buffer> <leader>/ :Toc<CR>
noremap <buffer> <leader>tf :TableFormat<CR>
noremap <buffer> <leader>- o<esc>I- 
set tw=80
" set foldmethod=syntax
noremap <buffer> <silent> <leader>oo :call wiki#OpenFileAndEnterText(expand("%:h")."/".expand("<cfile>"), expand("<cfile>"))<cr>
noremap <buffer> <silent> <leader>cfl :call wiki#CreateFileLink()<cr>
noremap <buffer> <silent> <leader>cdl :call wiki#CreateFolderLink()<cr>
