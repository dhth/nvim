"maps for git fugitive, from https://www.youtube.com/watch?v=PO6DxfGPQvw
nnoremap <silent> <leader>gs :G<CR>
nnoremap <silent> <leader>dm :Gvdiffsplit origin/master:%<CR>
nnoremap <silent> <leader>gf :diffget //2<CR>                    " used during merge conflicts
nnoremap <silent> <leader>gj :diffget //3<CR>
nnoremap <silent> <leader>ds :Gvdiffsplit HEAD:%<CR>
nnoremap <leader>gppp :Gpush
