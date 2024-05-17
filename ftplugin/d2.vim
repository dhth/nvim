nnoremap <silent> <buffer> f<c-f> :lua require("dhth.code_helpers").format_d2()<CR>

nnoremap <silent> <buffer> <leader><leader> :lua require("dhth.code_helpers").d2_code_to_file()<CR>
