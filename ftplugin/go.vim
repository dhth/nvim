nnoremap <silent> <buffer> <leader>rm :lua require("dhth.code_helpers").go_run(false)<CR>

nnoremap <silent> <buffer> <leader><cr> :VimuxRunCommand('go run '.expand('%'))<CR>
