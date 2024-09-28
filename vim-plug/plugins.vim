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
Plug 'ellisonleao/gruvbox.nvim'

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
Plug 'folke/neodev.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

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
Plug 'nvim-lualine/lualine.nvim'
Plug 'romgrk/barbar.nvim'

""" Moving around
Plug 'ggandor/leap.nvim'

""" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'

""" Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown', { 'for': 'markdown' }
Plug 'ferrine/md-img-paste.vim', { 'for': 'markdown' }

""" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
" , {'commit': '7135321cc254fd2a543f596a3648fdc481e54eef'}
" https://github.com/nvim-treesitter/nvim-treesitter/issues/2014
" 'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'romgrk/nvim-treesitter-context'
Plug 'echasnovski/mini.indentscope', { 'branch': 'stable' }
Plug 'stevearc/aerial.nvim'

""" Assist
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

""" Other
Plug 'tpope/vim-unimpaired'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'azabiong/vim-highlighter'
Plug 'terrastruct/d2-vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'mbbill/undotree'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'benmills/vimux'                                        " send commands to tmux
Plug 'vim-test/vim-test'
Plug 'junegunn/vim-slash'
Plug 'farmergreg/vim-lastplace'                              " remembers last editing place
Plug 'junegunn/vim-easy-align'                               " easy aligning around a character
Plug 'machakann/vim-highlightedyank'
Plug 'folke/trouble.nvim'
Plug 'mcchrish/nnn.vim'
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }
call plug#end()
