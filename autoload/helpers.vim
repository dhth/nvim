function! s:HelperCommandToRun(command)
    " if a:command ==? "create file"
    "     call fzf#run(fzf#wrap({'source': 'fd -H -t d', 'sink': function('s:CreateFileHelper')}))
    if a:command ==? "e .zshrc"
        tabnew $HOME/.zshrc
    elseif match(a:command, '^scala\:*', 0) == 0
        if match(a:command, '^scala\:runMain', 0) == 0
            VimuxRunCommand("runMain " . substitute(split(expand('%:r'), "src/main/scala/")[-1], '/', '.', 'g'))
        else
            VimuxRunCommand(split(a:command, "scala:")[-1])
        endif
    elseif a:command ==? "e helpers"
        tabnew $NVIM_DIR/autoload/helpers.vim
    elseif a:command ==? "e journal"
        tabnew $NVIM_DIR/journal.md
    elseif a:command ==? "e pomodoro"
        tabnew $POMODORO_TASK_LIST_FILE_LOC
    elseif a:command ==? "e karabiner"
        tabnew $HOME/.config/karabiner.edn
    elseif a:command ==? "e alacritty"
        tabnew $HOME/.config/alacritty/alacritty.yml
    elseif a:command ==? "e gitfile"
        tabnew $HOME/.global.gitfile
    elseif a:command ==? "e tools"
        tabnew $ALFRED_DIR/tools/tools.txt
    elseif a:command ==? "notes"
        tabnew local_notes.md
    elseif a:command ==? "e local commands"
        tabnew local_commands.txt
    elseif a:command ==? "e aws services"
        tabnew $ALFRED_DIR/aws/aws_services/aws_services.txt
    elseif a:command ==? "e docker commands"
        tabnew $HOME/docker_commands.txt
    elseif a:command ==? "local:8000"
        silent !open 'http://127.0.0.1:8000'
        echon ''
    elseif a:command ==? "local:8001"
        silent !open 'http://127.0.0.1:8001'
        echon ''
    elseif a:command ==? "local:8080"
        silent !open 'http://127.0.0.1:8080'
        echon ''
    elseif a:command ==? "__init__"
        let l:new_file = expand('%:p:h').'/__init__.py'
        execute '!touch ' . l:new_file
    elseif a:command ==? "lint"
        Dispatch $HOME/.virtualenvs/general/bin/pylint $(pwd)
    elseif a:command ==? "black"
        Dispatch $HOME/.virtualenvs/general/bin/black $(pwd)
    elseif a:command ==? "isort"
        Dispatch $HOME/.virtualenvs/general/bin/isort $(pwd)
    elseif a:command == "get staged files"
        Dispatch $HOME/.virtualenvs/general/bin/python -m utils.get_staged_file_names | pbcopy
    elseif a:command == "add recently modified links"
        Dispatch $HOME/.virtualenvs/general/bin/python -m utils.add_recently_modified_links
    elseif a:command == "lcd nvim"
        lcd ~/.config/nvim
    elseif a:command == "lcd alfred"
        lcd $ALFRED_DIR
    elseif a:command == "lcd dotfiles"
        lcd $DOT_FILES_DIR
    elseif a:command == "lcd wiki"
        lcd $WIKI_DIR
    elseif a:command == "lcd project"
        echom 'fd -H -t d ' . $PROJECTS_DIR
        call fzf#run(fzf#wrap({'source': 'fd -H -t d --max-depth 3 --base-directory ' . $PROJECTS_DIR, 'sink': function('s:LcdToProjectDirHelper')}))
        lcd $WIKI_DIR

    endif
endfunction

function! helpers#Helpers()
    if &filetype ==# 'scala'
        let l:commands = [
                    \"scala:runMain",
                    \"scala:fbrdCompliance",
                    \"scala:test",
                    \"scala:reload;fbrdCompliance",
                    \"scala:reload;fbrdCompliance;compile;test",
                    \"scala:fbrdCompliance;compile;test",
                    \"scala:testQuick",
                    \"scala:compile",
                    \"scala:reload",
                    \"scala:run",
                    \"scala:clean",
                    \"scala:docs/previewSite",
                    \]
        let l:window_height = 5
        let l:window_width = 3
    else
        let l:commands = [
                    \"e .zshrc",
                    \"e helpers",
                    \"e journal",
                    \"e pomodoro",
                    \"e karabiner",
                    \"e alacritty",
                    \"e gitfile",
                    \"e docker commands",
                    \"e tools",
                    \"e local commands",
                    \"e aws services",
                    \"notes",
                    \"get staged files",
                    \"add recently modified links",
                    \"lcd nvim",
                    \"lcd alfred",
                    \"lcd dotfiles",
                    \"lcd wiki",
                    \"lcd project",
                    \]
        let l:window_height = 6
        let l:window_width = 3
    endif
    return fzf#run({'source': l:commands, 'sink': function('s:HelperCommandToRun'),  'window': { 'width': l:window_width / 10.0 , 'height': l:window_height / 10.0 } })
endfunction

function! s:LcdToProjectDirHelper(location)
    let l:new_location = trim($PROJECTS_DIR . "/" . a:location)
    execute "lcd " . l:new_location
endfunction


function! s:CreateFileHelper(command)
    call inputsave()
    let l:file_name_in = input('Enter file name: ')
    call inputrestore()
    if len(l:file_name_in) > 0
        execute "tabnew ".a:command."/".l:file_name_in
        write
    endif
endfunction


function! helpers#CreateFile()
    call fzf#run(fzf#wrap({'source': 'fd -H -t d', 'sink': function('s:CreateFileHelper')}))
endfunction


function! helpers#AddDate()
    let l:date = system("date '+%Y-%m-%d' | tr -d '\n'")
    execute 'normal! i' . l:date
endfunction

function! helpers#LocalNotes()
    " let l:project_root = trim(system("git rev-parse --show-toplevel"))
    " echo l:project_root."/local_wiki.md"
    " execute "tabnew " . l:project_root ."/local_wiki.md"
    tabnew local_wiki.md
endfunction


function! helpers#GetCommitsForDiffOpen()
    "more at https://github.com/junegunn/fzf.vim/blob/master/autoload/fzf/vim.vim#L1203
    "shows commits for current branch, needs --all to show commits for all branches
    "--ansi in fzf options shows colors using shell codes
    let source = 'git log --graph --since="2 weeks ago" '.get(g:, 'fzf_commits_log_options', '--color=always '.fzf#shellescape('--format=%C(auto)%h%d %s %C(green)%cr'))
    let b:start_commit="0"
    let b:end_commit="0"
    call fzf#run(fzf#wrap({'source': source, 'sink': function('s:CommitHelper'), 'options': '--multi=2 --ansi'}))
endfunction


function! s:CommitHelper(commit_data)
    let commit_hash = trim(split(split(a:commit_data, "<<")[1], ">>")[0])
    if b:end_commit ==# "0"
        let b:end_commit = commit_hash
    elseif b:start_commit ==# "0"
        let b:start_commit = commit_hash
    endif
    " hack to get data from multiple choices from FZF
    " [TODO] find a better way for this
    if (b:end_commit != "0" && b:start_commit != "0")
        execute 'DiffviewOpen '.b:start_commit.'...'.b:end_commit
    endif
endfunction


function! helpers#LCDToDir()
    call fzf#run(fzf#wrap({'source': 'fd . -t d --max-depth=1 $PROJECTS_DIR $WORK_DIR $DOT_FILES_DIR $CONFIG_DIR $OTHER_PEOPLES_DOTFILES_DIR', 'sink': function('s:LCDToDirHelper')}))
endfunction


function! helpers#SearchProjects()
    call fzf#run(fzf#wrap({'source': 'fd . -t d --max-depth=1 $PROJECTS_DIR $WORK_DIR $DOT_FILES_DIR $CONFIG_DIR $OTHER_PEOPLES_DOTFILES_DIR $DROPBOX_DIR', 'sink': function('s:SearchProjectsHelper')}))
endfunction


function! s:SearchProjectsHelper(address)
    " echom "lua require('telescope.builtin').find_files({cwd=\"" . a:address . "\"})"
    " execute "lua require('dhth.telescope').search_dirs(\"" . a:address . "\")"
    execute "FZF " . a:address
endfunction


function! s:LCDToDirHelper(address)
    tabnew a:address
    execute "lcd " . a:address
endfunction


function! helpers#GvdiffHeadsplitHelper()
    call inputsave()
    let l:base_commit = input('Gvdiffsplit HEAD~? ')
    call inputrestore()
    execute 'Gvdiffsplit! HEAD~'.l:base_commit.':%'
endfunction

function! helpers#GvdiffsplitHelper()
    call inputsave()
    let l:ref = input('Gvdiffsplit HEAD~? ')
    call inputrestore()
    execute 'Gvdiffsplit! '.l:ref.':%'
endfunction


function! s:DiffWithRevHelper(rev)
    execute 'Gvdiffsplit! '.a:rev.':%'
endfunction


function! helpers#DiffWithRev()
    let source = 'git branch --all'
    call fzf#run(fzf#wrap({'source': source, 'sink': function('s:DiffWithRevHelper')}))
endfunction


function! s:DiffWithCommitHelper(commit_data)
    let l:commit_hash = trim(split(a:commit_data, " ")[0])
    execute 'Gvdiffsplit! '.l:commit_hash.':%'
    " execute "wincmd H"
    " execute "wincmd l"
endfunction


function! helpers#DiffWithCommit()
    let source = 'git log ' . get(g:, 'fzf_commits_log_options', '--color=always '.fzf#shellescape('--format=%C(auto)%h%d %s %C(green)%cr')) . ' ' . expand('%:t')
    call fzf#run(fzf#wrap({'source': source, 'sink': function('s:DiffWithCommitHelper'), 'options': '--ansi --inline-info'}))
endfunction


function! helpers#DispatchHelper()
    " Dispatch ls -1
    let l:results = system('sh run_tests.sh')
    echom l:results
endfunction


function! helpers#SearchToQuickfix()
    call inputsave()
    let l:pattern = input('pattern? ')
    call inputrestore()
    let l:raw_lines = systemlist("fd -ipH -t f '" . l:pattern . "'")
    let l:non_empty_lines = filter(l:raw_lines, { key, val -> val != '' })
    let l:data = map(l:non_empty_lines, '{"filename": v:val}')
    call setqflist(l:data)
    copen
endfunction
