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

" Plug 'gruvbox-community/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'KeitaNakamura/neodark.vim'
" Plug 'cormacrelf/vim-colors-github'
" Plug 'bluz71/vim-nightfly-guicolors'
" Plug 'sainnhe/sonokai'
" Plug 'ajmwagar/vim-deus'
" Plug 'folke/tokyonight.nvim'
" Plug 'wadackel/vim-dogrun'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lspconfig'
Plug 'vim-airline/vim-airline'
" Plug 'hoob3rt/lualine.nvim'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'tpope/vim-unimpaired'
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/gv.vim', { 'on': 'GV' }                       " see commit history
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-signify'
Plug 'junegunn/vim-easy-align'                               " easy aligning around a character
Plug 'godlygeek/tabular', { 'for': 'markdown' }              " dependency for vim-markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'ferrine/md-img-paste.vim', { 'for': 'markdown' }
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'benmills/vimux'                                        " send commands to tmux
Plug 'junkblocker/git-time-lapse', { 'on': 'GitTimeLapse' }  " see commit history for a file
Plug 'vim-test/vim-test', { 'on': 'TestNearest' }
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-dispatch'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' } " profiling tool
Plug 'MattesGroeger/vim-bookmarks'                           " bookmarks per line
Plug 'farmergreg/vim-lastplace'                              " remembers last editing place
" Plug 'preservim/tagbar'                                      " class outline viewer
" Plug 'junegunn/vader.vim'                                    " testing tool for vim files
Plug 'szw/vim-maximizer'
Plug 'sheerun/vim-polyglot'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Plug 'puremourning/vimspector'
" Plug 'jupyter-vim/jupyter-vim'
Plug 'machakann/vim-highlightedyank'
" Plug 'relastle/vim-nayvy'
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'


call plug#end()

let g:coc_global_extensions = ["coc-pyright",
            \ "coc-json",
            \ "coc-snippets"]
