nnoremap <leader>pv :NERDTreeToggle %<CR>

" enable line numbers in nerdtree
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
" make sure relative line numbers are used

let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.history$', 'node_modules']

augroup nerdtree_numbers
    autocmd!
    autocmd FileType nerdtree setlocal relativenumber
augroup END
