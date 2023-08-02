"folds on by default
" set foldmethod=indent
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
"prevents { or } from opening up a fold
" set foldopen-=block

" set nofoldenable

"leader fi to toggle opening/closing all folds
" let $unrol=0
" function UnrolMe()
" if $unrol==0
"     :exe "normal zR"
"     " :exe "normal zA"
"     let $unrol=1
" else
"     :exe "normal zM"
" " :exe "normal zC"
"     let $unrol=0
" endif
" endfunction

" noremap <silent> <leader>za :call UnrolMe()<CR>
" nnoremap za zA
" nnoremap zA za

"leader op opens fold
" noremap <silent> <leader><space> zA
"leader cl closes folds
" noremap <silent> <leader>cl zC

augroup MarkdownFolds
  au!
  au FileType markdown setlocal foldmethod=expr
  au FileType markdown setlocal foldexpr=CustomMarkdownFold(v:lnum)
  autocmd FileType markdown setlocal foldlevel=0
augroup END

" Define the custom fold expression function
function! CustomMarkdownFold(lnum)
  " Get the current line's content
  let line = getline(a:lnum)

  " Check if the line contains the start marker or end marker
  if line =~# '<!-- Links -->'
    return ">1"   " Mark the line as the start of a fold
  elseif line =~# '<!-- Links end -->'
    return "<1"   " Mark the line as the end of a fold
  else
    return "="    " Use '=' to keep the default folding behavior for other lines
  endif
endfunction
