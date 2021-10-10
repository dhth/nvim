"maps for git fugitive, from https://www.youtube.com/watch?v=PO6DxfGPQvw
nnoremap <silent> <leader>gs :G<CR>
nnoremap <silent> <leader>dm :Gvdiffsplit! origin/master:%<CR>
nnoremap <silent> <leader>gf :diffget //2<CR>                    " used during merge conflicts
nnoremap <silent> <leader>gj :diffget //3<CR>
nnoremap <silent> <leader>ds :Gvdiffsplit! HEAD:%<CR>
nnoremap <silent> <leader>ca :Git commit --amend<CR>
nnoremap <leader>gppp :Gpush
nnoremap <silent> <leader>gb :GBrowse<CR>
nnoremap <silent> <leader>df :Git difftool -y<space>
