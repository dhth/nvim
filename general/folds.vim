"folds on by default
set foldmethod=indent
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
"prevents { or } from opening up a fold
set foldopen-=block

set nofoldenable

"leader fi to toggle opening/closing all folds
let $unrol=0
function UnrolMe()
if $unrol==0
    :exe "normal zR"
    " :exe "normal zA"
    let $unrol=1
else
    :exe "normal zM"
" :exe "normal zC"
    let $unrol=0
endif
endfunction

noremap <silent> <leader>za :call UnrolMe()<CR>
" nnoremap za zA
" nnoremap zA za

"leader op opens fold
" noremap <silent> <leader><space> zA
"leader cl closes folds
noremap <silent> <leader>cl zC
