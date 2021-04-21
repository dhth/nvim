function! s:HelperCommandToRun(command)
    if a:command ==? "create file"
        call fzf#run(fzf#wrap({'source': 'fd -H -t d', 'sink': function('s:CreateFileHelper')}))
    elseif a:command ==? "e .zshrc"
        tabnew $HOME/.zshrc
    elseif a:command ==? "e journal"
        tabnew $NVIM_DIR/journal.md
    elseif a:command ==? "notes"
        tabnew local_notes.md
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
    elseif a:command == "lcd dotfiles"
        lcd $DOT_FILES_DIR
    elseif a:command == "lcd wiki"
        lcd $WIKI_DIR
    endif
endfunction

function! helpers#Helpers()
    let l:commands = [
                \"create file",
                \"e .zshrc",
                \"e journal",
                \"notes",
                \"local:8000", 
                \"local:8001",
                \"local:8080",
                \"get staged files",
                \"add recently modified links",
                \"lcd nvim",
                \"lcd dotfiles",
                \"lcd wiki"
                \]
    return fzf#run({'source': l:commands, 'sink': function('s:HelperCommandToRun'),  'window': { 'width': 0.3, 'height': 0.5 } })
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


function! helpers#LocalNotes()
    " let l:project_root = trim(system("git rev-parse --show-toplevel"))
    " echo l:project_root."/local_wiki.md"
    " execute "tabnew " . l:project_root ."/local_wiki.md"
    tabnew local_wiki.md
endfunction
