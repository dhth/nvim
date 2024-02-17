setlocal formatprg="shfmt -ln bash"
nnoremap <buffer> <silent> f<c-f> :%!shfmt -ln bash -i 4<cr>   
