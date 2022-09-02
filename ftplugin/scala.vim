inoremap <buffer> Í <space>=><space>
nnoremap <buffer> Í a<space>=><space>

inoremap <buffer> Å <space><-<space>
nnoremap <buffer> Å a<space><-<space>

" nnoremap <silent> <buffer> <leader>cm :VimuxRunCommand("compile")<CR>

set colorcolumn=0

" setlocal foldmethod=indent
" set foldlevelstart=-1
" setlocal foldmethod=expr
" setlocal foldexpr=nvim_treesitter#foldexpr()
nnoremap <silent> <buffer> <leader>db :normal Iprintln(A)

nnoremap <silent> <buffer> <leader>rm :VimuxRunCommand("runMain " . substitute(split(expand('%:r'), "src/main/scala/")[-1], '/', '.', 'g'))<CR>
