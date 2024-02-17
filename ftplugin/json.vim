setlocal formatprg=jq
setlocal cursorcolumn
nnoremap <buffer> <silent> f<c-f> :%!jq '.'<cr>   
nnoremap <buffer> <silent> <leader>ff :%!jq<cr>   
"refactor this to restore cursor position
