setlocal formatprg=jq
setlocal cursorcolumn
nnoremap <buffer> <silent> <leader>rf :%!jq '.'<cr>   
nnoremap <buffer> <silent> <leader>ff :%!jq<cr>   
"refactor this to restore cursor position
