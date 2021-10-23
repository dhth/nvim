"builtin
nnoremap <silent> <leader>re <cmd>lua require('telescope.builtin').resume()<CR>
nnoremap <silent> <leader>bc <cmd>lua require('telescope.builtin').git_bcommits()<CR>
nnoremap <silent> <C-b> <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <C-s> <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({previewer=false, prompt_title="search", sorting_strategy="ascending", layout_config={prompt_position="top"}})<cr>
nnoremap <silent> <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <silent> <leader>ts <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <silent> <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <silent> <leader>l <cmd>lua require('telescope.builtin').live_grep({previewer=false})<cr>
nnoremap <silent> <leader>ss :Telescope grep_string search=<c-r><c-w><cr>
nnoremap <silent> <leader>sm :Telescope coc document_symbols<cr>
nnoremap <silent> <leader>sw :Telescope grep_string search=<c-r><c-w><cr>
nnoremap <silent> <leader>vh :Telescope help_tags<CR> 
nnoremap <silent> <leader>dg :Telescope coc diagnostics<CR>


" custom
nnoremap <silent> <leader>w2 <cmd>lua require('dhth.telescope').search_work_wiki()<CR>
nnoremap <silent> <leader>ww <cmd>lua require('dhth.telescope').search_wiki()<CR>
nnoremap <silent> <leader>tf <cmd>lua require('dhth.telescope').find_test_files()<CR>
nnoremap <silent> <leader>lo <cmd>lua require('dhth.telescope').find_local_only_files()<CR>
nnoremap <silent> <leader>sy <cmd>lua require('dhth.telescope').find_docker_compose_files()<CR>
nnoremap <silent> <leader>dkf <cmd>lua require('dhth.telescope').find_dockerfiles()<CR>
nnoremap <silent> <C-f> <cmd>lua require('dhth.telescope').find_files()<CR>
nnoremap <silent> <leader>dt <cmd>lua require('dhth.telescope').edit_dotfiles()<CR>
nnoremap <silent> <leader>vg <cmd>lua require('dhth.telescope').grep_nvim()<CR>
nnoremap <silent> <leader>vv <cmd>lua require('dhth.telescope').edit_neovim()<CR>
