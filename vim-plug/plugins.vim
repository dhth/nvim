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

" Colorschemes
" Plug 'gruvbox-community/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
" Plug 'KeitaNakamura/neodark.vim'
" Plug 'shaunsingh/moonlight.nvim'
" Plug 'cormacrelf/vim-colors-github'
" Plug 'bluz71/vim-nightfly-guicolors'
" Plug 'sainnhe/sonokai'
" Plug 'ajmwagar/vim-deus'
" Plug 'folke/tokyonight.nvim'
" Plug 'arzg/vim-colors-xcode'
" Plug 'wadackel/vim-dogrun'
Plug 'dracula/vim'

" Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'stsewd/fzf-checkout.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

""" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/lua-dev.nvim'
Plug 'ray-x/lsp_signature.nvim'

""" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'

""" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'

""" Tabline, Bufferline
Plug 'vim-airline/vim-airline'
" Plug 'nvim-lualine/lualine.nvim'
" Plug 'kdheepak/tabline.nvim'
" Plug 'romgrk/barbar.nvim'

Plug 'tpope/vim-commentary'
" Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
" Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'tpope/vim-unimpaired'
" Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'junegunn/gv.vim', { 'on': 'GV' }                       " see commit history
Plug 'justinmk/vim-sneak'
" Plug 'mhinz/vim-signify'
Plug 'lewis6991/gitsigns.nvim'
Plug 'junegunn/vim-easy-align'                               " easy aligning around a character
" Plug 'godlygeek/tabular', { 'for': 'markdown' }              " dependency for vim-markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'ferrine/md-img-paste.vim', { 'for': 'markdown' }
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'junkblocker/git-time-lapse', { 'on': 'GitTimeLapse' }  " see commit history for a file
Plug 'benmills/vimux'                                        " send commands to tmux
Plug 'vim-test/vim-test'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-dispatch'
" Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' } " profiling tool
" Plug 'MattesGroeger/vim-bookmarks'                           " bookmarks per line
Plug 'farmergreg/vim-lastplace'                              " remembers last editing place
" Plug 'preservim/tagbar'                                      " class outline viewer
" Plug 'junegunn/vader.vim'                                    " testing tool for vim files
Plug 'szw/vim-maximizer'
" Plug 'sheerun/vim-polyglot'
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Plug 'puremourning/vimspector'
Plug 'machakann/vim-highlightedyank'
" Plug 'sindrets/diffview.nvim'  " git-split-diffs works better
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'fannheyward/telescope-coc.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'folke/todo-comments.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'mcchrish/nnn.vim'
" Plug 'luukvbaal/nnn.nvim'
Plug 'ThePrimeagen/harpoon'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'nvim-treesitter/playground'

Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'pwntester/octo.nvim'

Plug 'rcarriga/nvim-notify'
Plug 'mhinz/vim-startify'
" Plug 'tpope/vim-projectionist'
" Plug 'untitled-ai/jupyter_ascending.vim'
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

let g:pydocstring_formatter = 'sphinx'

" let g:coc_global_extensions = ["coc-pyright",
"             \ "coc-json",
"             \ "coc-yaml",
"             \ "coc-snippets"]
