nnoremap <silent> <buffer> f<c-f> :lua require("custom.helpers.code.general").format_d2()<CR>

nnoremap <silent> <buffer> <leader><leader> :lua require("custom.helpers.code.general").d2_code_to_file()<CR>
