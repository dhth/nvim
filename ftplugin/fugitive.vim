nnoremap <silent> <buffer> <leader><leader> <cmd>lua require("custom.helpers.git").git_commands()<CR>

" nnoremap <silent> <buffer> <leader>cc :12split term://c<CR>
nnoremap <silent> <buffer> <leader>gp <cmd>lua require("custom.helpers.git").git_push()<CR>

nnoremap <silent> <buffer> <C-e> :NnnPicker<CR>
