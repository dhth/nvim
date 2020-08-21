" vim-plug auto setup
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-unimpaired'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'junegunn/gv.vim'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-signify'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ferrine/md-img-paste.vim'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'mzlogin/vim-markdown-toc'
"Plug 'vimwiki/vimwiki'
" Plug 'unblevable/quick-scope'
" Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junkblocker/git-time-lapse'
" Plug 'chriskempson/base16-vim'
Plug 'vim-test/vim-test'
" Plug 'Rigellute/shades-of-purple.vim'

call plug#end()

let g:coc_global_extensions = ["coc-python",
            \ "coc-json",
            \ "coc-snippets"]
