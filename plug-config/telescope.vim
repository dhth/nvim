"builtin
nnoremap <silent> <leader>re <cmd>lua require('telescope.builtin').resume()<CR>
" nnoremap <silent> <leader>df <cmd>lua require('telescope.builtin').git_bcommits()<CR>
nnoremap <silent> <C-b> <cmd>lua require('telescope.builtin').buffers({previewer=false})<CR>
nnoremap <silent> <C-s> <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({previewer=false, prompt_title="search", sorting_strategy="ascending", layout_config={prompt_position="top"}})<cr>
nnoremap <silent> <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <silent> <leader>ts <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <silent> <leader>vh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <silent> <leader>sh <cmd>lua require("telescope.builtin").search_history(require("telescope.themes").get_ivy({ results_title = false, layout_config = { height = .6 }}))<CR>
" nnoremap <silent> <leader>ll <cmd>lua require('telescope.builtin').live_grep({previewer=false})<cr>
nnoremap <silent> <leader>ll <cmd>lua require("telescope").extensions.live_grep_args.live_grep_args(require("telescope.themes").get_ivy({prompt_title = "~ grep ~", results_title = false, preview_title = false}))<CR>
nnoremap <silent> <c-f> <cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_ivy({ find_command = { "fd", "-ipH", "-t=f" }, prompt_title = "~ search files ~" , results_title = false, previewer = false, layout_config = { height = .6 } }))<CR>
" nnoremap <silent> <leader>rr <cmd>lua require('telescope.builtin').lsp_references({previewer=true})<cr>
nnoremap <silent> <leader>ii <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <silent> <leader>oo <cmd>split \| lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <silent> <leader>ss :Telescope persisted<CR>
nnoremap <silent> <leader>sm <cmd>lua require('dhth.telescope').search_document_symbols()<cr>
nnoremap <silent> <leader>sw :Telescope grep_string search=<c-r><c-w><cr>
nnoremap <silent> <leader>si :Telescope lsp_implementations search=<c-r><c-w><cr>
nnoremap <silent> <leader>dg :Telescope lsp_document_diagnostics<CR>


" custom
nnoremap <silent> <leader>w2 <cmd>lua require('dhth.telescope').search_work_wiki()<CR>
nnoremap <silent> <leader>ww <cmd>lua require('dhth.telescope').search_wiki()<CR>
nnoremap <silent> <leader>tf <cmd>lua require('dhth.telescope').find_test_files()<CR>
nnoremap <silent> <leader>lo <cmd>lua require('dhth.telescope').find_local_only_files()<CR>
nnoremap <silent> <leader>sy <cmd>lua require('dhth.telescope').find_docker_compose_files()<CR>
nnoremap <silent> <leader>dkf <cmd>lua require('dhth.telescope').find_dockerfiles()<CR>
" nnoremap <silent> <C-f> <cmd>lua require('dhth.telescope').find_files()<CR>
" nnoremap <silent> <leader>dt <cmd>lua require('dhth.telescope').edit_dotfiles()<CR>
nnoremap <silent> <leader>vg <cmd>lua require('dhth.telescope').grep_nvim()<CR>
nnoremap <silent> <leader>cc <cmd>lua require('dhth.telescope').edit_neovim()<CR>
nnoremap <silent> <leader>lt <cmd>lua require('dhth.telescope').search_linked_tests()<CR>
nnoremap <silent> <leader>sf <cmd>lua require('dhth.telescope').nearby_file_browser()<CR>
nnoremap <silent> <leader>gd <cmd>lua require('dhth.telescope').search_changed_files()<CR>
nnoremap <silent> <leader>nf <cmd>lua require('dhth.telescope').create_new_file_at_location()<CR>
nnoremap <silent> <leader>rf <cmd>lua require('dhth.telescope').search_related_files()<CR>
