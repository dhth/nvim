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
" nnoremap <silent> <buffer> <leader>db :normal Iprintln(A)

nnoremap <silent> <buffer> <leader>rm :lua require("dhth.code_helpers").scala_run(false)<CR>

" vimcript style bindings till I figure out why
" nvim-metals' on_attach function is not working
nnoremap <silent> <buffer> <leader>ff :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <buffer> <leader>vv :lua vim.cmd('vsp'); vim.lsp.buf.definition()<CR>
nnoremap <silent> <buffer> <leader>gi :lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <buffer> <leader>rr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> <buffer> M :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <buffer> <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <buffer> f<c-f> :lua vim.lsp.buf.format({async=true})<CR>
nnoremap <silent> <buffer> <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <buffer> [d :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <buffer> ]d :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <buffer> X :lua require("dhth.nvim_lspconfig.custom_hover").show_file_definition_path()<CR>

inoremap <buffer> .. <space>=><space>
inoremap <buffer> ,, <space><-<space>
