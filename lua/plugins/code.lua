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
        "junegunn/vim-easy-align",
        event = "InsertEnter",
        config = function()
            -- Start interactive EasyAlign in visual mode (e.g. vipga)
            REMAP("x", "ga", "<Plug>(EasyAlign)", OPTS_NO_REMAP_SILENT)

            -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
            REMAP("n", "ga", "<Plug>(EasyAlign)", OPTS_NO_REMAP_SILENT)
        end,
    },
    {
        "vim-scripts/ReplaceWithRegister",
        event = "InsertEnter",
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
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require "harpoon"
            NOREMAP_SILENT("n", "<leader>aa", function()
                harpoon:list():add()
            end)
            NOREMAP_SILENT("n", "<leader>`", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)
            NOREMAP_SILENT("n", "<leader><tab>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            NOREMAP_SILENT("n", "<leader>1", function()
                harpoon:list():select(1)
            end)
            NOREMAP_SILENT("n", "<leader>2", function()
                harpoon:list():select(2)
            end)
            NOREMAP_SILENT("n", "<leader>3", function()
                harpoon:list():select(3)
            end)
            NOREMAP_SILENT("n", "<leader>4", function()
                harpoon:list():select(4)
            end)
            NOREMAP_SILENT("n", "<leader>5", function()
                harpoon:list():select(5)
            end)
            NOREMAP_SILENT("n", "<leader>6", function()
                harpoon:list():select(6)
            end)
            NOREMAP_SILENT("n", "<C-[>", function()
                harpoon:list():prev()
            end)
            NOREMAP_SILENT("n", "<C-]>", function()
                harpoon:list():next()
            end)
        end,
    },
    {
        "ferrine/md-img-paste.vim",
        event = "InsertEnter",
    },
}
