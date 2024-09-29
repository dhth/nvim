nnoremap <silent> <buffer> <leader>rm :lua require("custom.helpers.code.go").go_run(false)<CR>

nnoremap <silent> <buffer> <leader><cr> :VimuxRunCommand('go run '.expand('%'))<CR>

nnoremap <silent> <buffer> <leader><leader> :lua require("custom.helpers.code.go").commands(false)<CR>
