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
" Plug 'lifepillar/vim-gruvbox8'
Plug 'ellisonleao/gruvbox.nvim'
" Plug 'KeitaNakamura/neodark.vim'
" Plug 'rebelot/kanagawa.nvim'
" Plug 'projekt0n/github-nvim-theme'
" Plug 'shaunsingh/moonlight.nvim'
" Plug 'cormacrelf/vim-colors-github'
" Plug 'bluz71/vim-nightfly-guicolors'
" Plug 'sainnhe/sonokai'
" Plug 'ajmwagar/vim-deus'
" Plug 'folke/tokyonight.nvim'
" Plug 'tiagovla/tokyodark.nvim'
" Plug 'arzg/vim-colors-xcode'
" Plug 'wadackel/vim-dogrun'
" Plug 'dracula/vim'
" Plug 'folke/twilight.nvim'

""" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'

""" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'scalameta/nvim-metals'
Plug 'glepnir/lspsaga.nvim', { 'commit': '0b3ee6a4fb2cb9c80c05fe7c191ea116bdda34f7' }
Plug 'folke/neodev.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'Maan2003/lsp_lines.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" A few LSPs support sending $/progress messages (https://github.com/j-hui/fidget.nvim/wiki/Known-compatible-LSP-servers)
" Plug 'j-hui/fidget.nvim' 

""" Completion
Plug 'hrsh7th/cmp-nvim-lsp', { 'commit': 'affe808a5c56b71630f17aa7c38e15c59fd648a8' }
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'

""" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'

""" Tabline, Bufferline
" Plug 'vim-airline/vim-airline'
Plug 'nvim-lualine/lualine.nvim'
" Plug 'kdheepak/tabline.nvim'
Plug 'romgrk/barbar.nvim'


""" Sessions
" Plug 'olimorris/persisted.nvim'

" Plug 'tpope/vim-commentary'
Plug 'numToStr/Comment.nvim'
" Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
" Plug 'folke/zen-mode.nvim'
" Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-unimpaired'
" Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'junegunn/gv.vim'

""" Moving around
Plug 'folke/flash.nvim'
" Plug 'justinmk/vim-sneak'
" Plug 'phaazon/hop.nvim'
" Plug 'ggandor/lightspeed.nvim'
" Plug 'ggandor/leap.nvim'
" Plug 'mfussenegger/nvim-treehopper'

""" Git
" Plug 'mhinz/vim-signify'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

Plug 'mbbill/undotree'

""" Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown', { 'for': 'markdown' }
Plug 'ferrine/md-img-paste.vim', { 'for': 'markdown' }

Plug 'vim-scripts/ReplaceWithRegister'
" Plug 'junkblocker/git-time-lapse', { 'on': 'GitTimeLapse' }  " see commit history for a file
Plug 'benmills/vimux'                                        " send commands to tmux
Plug 'vim-test/vim-test'
Plug 'junegunn/vim-slash'
Plug 'tpope/vim-dispatch'
" Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' } " profiling tool
" Plug 'MattesGroeger/vim-bookmarks'                           " bookmarks per line
Plug 'farmergreg/vim-lastplace'                              " remembers last editing place
" Plug 'preservim/tagbar'                                      " class outline viewer
" Plug 'junegunn/vader.vim'                                    " testing tool for vim files
" Plug 'szw/vim-maximizer'
" Plug 'sheerun/vim-polyglot'
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'junegunn/vim-easy-align'                               " easy aligning around a character
" Plug 'puremourning/vimspector'
Plug 'machakann/vim-highlightedyank'
Plug 'sindrets/diffview.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'mcchrish/nnn.vim'
Plug 'kevinhwang91/nvim-bqf'
" Plug 'luukvbaal/nnn.nvim'
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
" , {'commit': '7135321cc254fd2a543f596a3648fdc481e54eef'}
" https://github.com/nvim-treesitter/nvim-treesitter/issues/2014
" 'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'romgrk/nvim-treesitter-context'
Plug 'echasnovski/mini.indentscope', { 'branch': 'stable' }
Plug 'stevearc/aerial.nvim'
" Plug 'nvim-treesitter/playground'
" Plug 'HampusHauffman/block.nvim'
" Plug 'github/copilot.vim'
" Plug 'jellydn/CopilotChat.nvim'

" Plug 'nvim-neorg/neorg'

" Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'pwntester/octo.nvim'

" Plug 'rcarriga/nvim-notify'
Plug 'mhinz/vim-startify'
Plug 'azabiong/vim-highlighter'

" Plug 'tpope/vim-projectionist'
" Plug 'untitled-ai/jupyter_ascending.vim'
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'chentoast/marks.nvim'
" Plug 'purescript-contrib/purescript-vim'
call plug#end()

let g:pydocstring_formatter = 'sphinx'

" let g:coc_global_extensions = ["coc-pyright",
"             \ "coc-json",
"             \ "coc-yaml",
"             \ "coc-snippets"]
