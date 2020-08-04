"folds on by default
set foldmethod=indent
"prevents { or } from opening up a fold
set foldopen-=block

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

noremap <leader>za :call UnrolMe()<CR>

"leader op opens fold
noremap <leader><space> zA
"leader cl closes folds
noremap <leader>cl zC
