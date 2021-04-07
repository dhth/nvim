setlocal colorcolumn=80
nnoremap <buffer> <leader>ml f]gf
" nnoremap <buffer> <ENTER> 0f]<C-W>gf
nnoremap <buffer> <silent> <ENTER> :call wiki#EnterKeyActions(getline('.'))<cr>
nnoremap <buffer> <silent> <leader><ENTER> :call wiki#GoToFileInNewTab(getline('.'))<cr>
" augroup mdtoc
"     autocmd BufRead * Toc
" augroup END
" Open TOC and switch back to left window
" Toc
" wincmd h
nnoremap <buffer> <leader>/ :Toc<CR>
nnoremap <buffer> <leader>tf :TableFormat<CR>
" nnoremap <buffer> <leader>- o<esc>I- 
nnoremap <buffer> <leader>- o---<esc>k0i
nnoremap <buffer> <leader>x o<esc>I- [ ] 
set tw=80
" set foldmethod=syntax
nnoremap <buffer> <silent> <leader>oo :call wiki#OpenFileAndEnterText(expand("%:h")."/".expand("<cfile>"), expand("<cfile>"))<cr>
nnoremap <buffer> <silent> <leader>cfl :call wiki#CreateFileLink()<cr>
nnoremap <buffer> <silent> <leader>cdl :call wiki#CreateFolderLink()<cr>

nnoremap <buffer> <leader>ctr :call wiki#CreateBookTrackerRow()<cr>

nnoremap <buffer> <silent> <leader>tc :call ft#markdown#ToggleCocSuggestions()<cr>
nnoremap <buffer> <silent> <leader>al :call wiki#AddMarkdownLink()<cr>
nnoremap <buffer> <silent> <leader>ce :call wiki#CreateDateFileLink()<cr>
