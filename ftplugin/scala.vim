inoremap <buffer> Í <space>=><space>
nnoremap <buffer> Í a<space>=><space>

inoremap <buffer> Å <space><-<space>
nnoremap <buffer> Å a<space><-<space>

set colorcolumn=0

nnoremap <silent> <buffer> <leader>rm :lua require("custom.helpers.code.general").scala_run(true)<CR>

inoremap <buffer> .. <space>=><space>
inoremap <buffer> ,, <space><-<space>
