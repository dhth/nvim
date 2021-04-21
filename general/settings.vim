let mapleader = " "

syntax enable
set nocompatible
filetype plugin on
set splitbelow
set splitright
set noerrorbells
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number relativenumber
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set tw=120
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set colorcolumn=120
set showcmd
set ruler
set cursorline                          " enable highlighting of the current line
set conceallevel=0                      " to be able to see `` in markdown files
set updatetime=300                      " faster completion
set timeoutlen=300                      " default is 1000 ms
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set wildmenu
set wildignore+=**/node_modules/**
set clipboard+=unnamedplus
set inccommand=nosplit                    " Show live highlighting during substitute in a split window
set noshowmode

"from How to do 90% of what plugins do
"https://www.youtube.com/watch?v=XA2WjJbmmoM

"file finding
" set path+=**
" disabled after reading https://github.com/neovim/neovim/issues/3209

" autocmd! GUIEnter * set vb t_vb=

" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" highlight ColorColumn ctermbg=0 guibg=lightgrey

" keep yanked text highlighted for 5 seconds
" more here: https://www.reddit.com/r/neovim/comments/gofplz/neovim_has_added_the_ability_to_highlight_yanked/
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 5000)
augroup END

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = 'assets'
let g:mdip_imgname = 'img'

" https://salferrarello.com/vim-close-all-buffers-except-the-current-one/
command! BufOnly execute '%bdelete|edit #|normal `"'

" auto clean fugitive buffers
" from http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
autocmd BufReadPost fugitive://* set bufhidden=delete

set rtp+=/usr/local/opt/fzf

let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript']
