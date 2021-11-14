let g:flog_default_arguments = {
            \ 'max_count': 100,
            \ 'all': 1,
            \ 'date': 'short',
            \ }

" nnoremap <silent> <leader>fh :Flogsplit -path=%<CR> 
nnoremap <silent> <leader>gl :Flog<CR>
