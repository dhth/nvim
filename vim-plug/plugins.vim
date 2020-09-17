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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
" Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-signify'
Plug 'junegunn/vim-easy-align'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'ferrine/md-img-paste.vim', { 'for': 'markdown' }
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'benmills/vimux', { 'on': 'VimuxRunCommand' }
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'stsewd/fzf-checkout.vim'
Plug 'junkblocker/git-time-lapse', { 'on': 'GitTimeLapse' }
Plug 'vim-test/vim-test', { 'on': 'TestNearest' }
Plug 'KeitaNakamura/neodark.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-dispatch'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'junegunn/vim-emoji'

call plug#end()

let g:coc_global_extensions = ["coc-python",
            \ "coc-json",
            \ "coc-snippets"]
