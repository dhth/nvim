" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>ts <cmd>lua require('telescope.builtin').treesitter()<cr>

nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>

nnoremap <leader>ss :Telescope grep_string search=<c-r><c-w><cr>
nnoremap <leader>sm :Telescope coc document_symbols<cr>
nnoremap <leader>sw :Telescope grep_string search=<c-r><c-w><cr>
nnoremap <silent> <C-s> <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({previewer=false, prompt_title="search", sorting_strategy="ascending", layout_config={prompt_position="top"}})<cr>

nnoremap <leader>vh :Telescope help_tags<CR> 

nnoremap <leader>vv <cmd>lua require('dhth.telescope').edit_neovim()<CR>
nnoremap <leader>dt <cmd>lua require('dhth.telescope').edit_dotfiles()<CR>
nnoremap <silent> <leader>dg :Telescope coc diagnostics<CR>

nnoremap <C-f> <cmd>lua require('dhth.telescope').find_files()<CR>

nnoremap <leader>dkf <cmd>lua require('dhth.telescope').find_dockerfiles()<CR>
nnoremap <leader>sy <cmd>lua require('dhth.telescope').find_docker_compose_files()<CR>
nnoremap <leader>lo <cmd>lua require('dhth.telescope').find_local_only_files()<CR>
nnoremap <leader>tf <cmd>lua require('dhth.telescope').find_test_files()<CR>
nnoremap <silent> <C-b> <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <silent> <leader>bc <cmd>lua require('telescope.builtin').git_bcommits()<CR>
