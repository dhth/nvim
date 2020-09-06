inoremap jj <Esc>
" inoremap jk <Esc>
" inoremap kj <Esc>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Using vim-tmux-navigator now
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

nnoremap <c-[> <c-o>
nnoremap <c-]> <c-i>

"resize splits -> increase/decrease height
" nnoremap <silent> <Leader>+ :resize +5<CR>
" nnoremap <silent> <Leader>- :resize -5<CR>

"resize splits -> increase/decrease width of left pane
nnoremap <silent> <Leader>> :vertical resize +5<CR>
nnoremap <silent> <Leader>< :vertical resize -5<CR>

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

noremap <leader>fn :echo @%<CR>

"shortcut to edit nvim config
noremap <leader>ev :vsplit $MYVIMRC<CR>

"add a new line below with a breakpoint (python)
nnoremap <leader>bp obreakpoint()<Esc>k

noremap <leader>sv :source $MYVIMRC<CR>

"create empty line(s) below/above
nnoremap <silent> <leader>[ :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> <leader>] :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

"move line/block down/up,
"Ô is shift+opt+j 
" is shift+opt+k 
"alternative: ∆ is opt+j, ˚ is opt+k
"using the shift-opt version
"since opt+j is mapped in karabiner
nnoremap Ô :m .+1<CR>
nnoremap  :m .-2<CR>
inoremap Ô <Esc>:m .+1<CR>gi
inoremap  <Esc>:m .-2<CR>gi
vnoremap Ô :m '>+1<CR>gv
vnoremap  :m '<-2<CR>gv

" nnoremap <leader>u :UndotreeShow<CR>

" Due to the way <C-i> and <TAB> works in vim,
" changing <C-i> to <C-j>
" more on this here
" https://github.com/neoclide/coc.nvim/issues/1089
" nnoremap <C-j> <C-i>

nnoremap <leader>y yyp

" Movement to content of next braces
" from https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
onoremap in( :<c-u>normal! f(vi(<cr>

"terminal mappings
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

nnoremap <leader>pgs :!python get_staged_file_names.py<cr>
