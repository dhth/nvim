return {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "tpope/vim-unimpaired",
        event = "InsertEnter",
    },
    {
        "azabiong/vim-highlighter",
        event = "InsertEnter",
        init = function()
            vim.cmd [[let HiClear = 'ff<BS>']]
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "vim-scripts/ReplaceWithRegister",
        event = "InsertEnter",
        keys = {
            {
                "er",
                "<Plug>ReplaceWithRegisterOperator",
                desc = "ReplaceWithRegisterOperator",
            },
        },
    },
    {
        "machakann/vim-highlightedyank",
        event = "InsertEnter",
    },
    {
        "farmergreg/vim-lastplace",
    },
    {
        "benmills/vimux",
        event = "InsertEnter",
        dependencies = {
            { "vim-test/vim-test" },
        },
        init = function()
            vim.g.VimuxHeight = "20"
        end,
    },
    {
        "vim-test/vim-test",
        event = "InsertEnter",
        config = function()
            vim.cmd [[
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-t> :TestNearest<CR>:silent !tmux select-pane -t .+1 && tmux resize-pane -Z<CR>
nmap <silent> t<Down> :TestFile<CR>:silent !tmux select-pane -t .+1 && tmux resize-pane -Z<CR>
nmap <silent> t<Up> :TestSuite<CR>:silent !tmux select-pane -t .+1 && tmux resize-pane -Z<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "vimux"
let test#python#runner = 'pytest'
let g:test#echo_command = 0
let g:test#preserve_screen = 1

function! DockerTransform(cmd)
    let l:file_type = &filetype

    if l:file_type == "python"
        let l:final_cmd =  substitute(a:cmd, 'webapptests/webapptests/', '', 'g')
        let l:final_cmd =  substitute(l:final_cmd, 'livetests/livetests/', '', 'g')
        let l:final_cmd =  substitute(l:final_cmd, 'pytest', 'pytest -s -v', 'g')
        return l:final_cmd
    elseif l:file_type == "scala"
        " need to convert a command like
        " sbt "testOnly *ApplicationServiceSpec"
        " to
        " testOnly *ApplicationServiceSpec
        " or
        " sbt "testOnly *ApplicationServiceSpec -- -z \"create a new Application\""
        " to
        " testOnly *ApplicationServiceSpec -- -z \"create a new Application\"
        let l:command_els = split(a:cmd, " ")
        let l:command_els_needed = join(l:command_els[1:])
        let l:command_els_needed_stripped = l:command_els_needed[1:-2]
        return l:command_els_needed_stripped
    else
        return a:cmd
endfunction

function! CopyStrategy(cmd)
  return "echo '" .. a:cmd .. "' | pbcopy"
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform'), 'copy': function('CopyStrategy')}

let g:test#transformation = 'docker'
]]
        end,
    },
    {
        "mbbill/undotree",
        event = "InsertEnter",
        dependencies = {
            { "vim-test/vim-test" },
        },
        config = function()
            vim.cmd [[
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
]]
            REMAP(
                "n",
                "<leader>uu",
                ":UndotreeToggle<CR>",
                OPTS_NO_REMAP_SILENT
            )
        end,
    },
    {
        "ferrine/md-img-paste.vim",
        event = "InsertEnter",
    },
    {
        "echasnovski/mini.nvim",
        event = "InsertEnter",
        version = "*",
        config = function()
            require("mini.align").setup()
        end,
    },
    {
        "preservim/vim-markdown",
        event = "InsertEnter",
        dependencies = {
            { "godlygeek/tabular" },
        },
        init = function()
            vim.cmd [[let g:vim_markdown_folding_disabled = 1]]
        end,
    },
    {
        "catgoose/nvim-colorizer.lua",
    }
}
