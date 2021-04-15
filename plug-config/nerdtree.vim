nnoremap <silent> <leader>pv :NERDTreeToggle %<CR>
nnoremap <silent> <C-e> :NERDTreeToggle %<CR>

" enable line numbers in nerdtree
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
" make sure relative line numbers are used

let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.history$', 'node_modules', '__pycache__', '.pytest_cache']

augroup nerdtree_numbers
    autocmd!
    autocmd FileType nerdtree setlocal relativenumber
augroup END

let NERDTreeQuitOnOpen=1
