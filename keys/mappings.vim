" inoremap jj <Esc>
" inoremap jk <Esc>
" inoremap kj <Esc>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Better nav for omnicomplete
" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")

" Mapping up and down keys
" since, <c-j> and <c-k> are
" mapped to up and down via
" karabiner
inoremap <expr> <Down> ("\<C-n>")
inoremap <expr> <Up> ("\<C-p>")

" nnoremap <C-h> <c-w>h
" nnoremap <C-j> <c-w>j
" nnoremap <C-k> <c-w>k
" nnoremap <C-l> <c-w>l

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
noremap <silent> <leader>cf :!echo -n % \| pbcopy<CR>

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
tnoremap <C-w>z <C-\><C-n><C-w>_
" tnoremap jj <C-\><C-n>

" Move to end of line while in insert mode
" <C-o> puts you in Normal mode for just one command
inoremap aa <C-o>$
" gf if file does not exist, relative to current dir
noremap <leader>grf :tabe %:h/<cfile><CR>
noremap <leader>gcf :tabe <cfile><CR>
nnoremap <leader>gf <c-w>gF
nnoremap <leader><enter> <c-w>gF
autocmd FileType qf nnoremap <leader><enter> <c-w>gF

nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" nnoremap <C-e> :Vex<CR>
inoremap <c-l> <C-o>a

nnoremap <leader>\ :vnew<cr>:Files<cr>

nnoremap <leader>\ :vnew<cr>
nnoremap <leader>- :new<cr>

nnoremap <leader>th :call themes#ChangeColorsPopUp()<cr>

" journal entry
nnoremap <leader>je :e ~/.config/nvim/journal.md<cr>

nnoremap <silent> <leader>mm :MaximizerToggle<cr>

nnoremap <silent> <leader>bo :BufOnly<cr>

nnoremap <silent> t<c-t> :call helpers#Helpers()<cr>
nnoremap <silent> <leader>pp :call helpers#LCDToDir()<cr>

" create new file using fzf
nnoremap <silent> <leader>nn :call helpers#CreateFile()<cr>

nnoremap <silent><leader>cc :silent !cat % \| pbcopy<cr>

" directly open wiki page
nnoremap <silent> <leader>, :call wiki#OpenWikiPageInBrowser()<cr>
nnoremap <silent> <leader>. :call wiki#OpenWorkWikiPageInBrowser()<cr>
nnoremap <silent> <leader>dv :call helpers#GetCommitsForDiffOpen()<cr>
nnoremap <silent> <leader>as :call aws_helpers#Search()<cr>
nnoremap <silent> <leader>cw :call aws_helpers#SearchCDKAPIReferenceForCurrentWord()<cr>
nnoremap <silent> <leader>dd :call helpers#GvdiffsplitHelper()<cr>
