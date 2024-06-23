nnoremap <silent> <buffer> <leader>rm :lua require("dhth.code_helpers.go").go_run(false)<CR>

nnoremap <silent> <buffer> <leader><cr> :VimuxRunCommand('go run '.expand('%'))<CR>

nnoremap <silent> <buffer> <leader><leader> :lua require("dhth.code_helpers.go").commands(false)<CR>
