function! s:HelperCommandToRun(command)
    if a:command ==? "local:8000"
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
    endif
endfunction

function! helpers#Helpers()
    let l:commands = ["local:8000", 
                \"local:8001",
                \"local:8080",
                \"get staged files",
                \"add recently modified links",
                \"lcd nvim",
                \"lcd dotfiles"
                \]
    return fzf#run({'source': l:commands, 'sink': function('s:HelperCommandToRun'),  'window': { 'width': 0.4, 'height': 0.4 } })
endfunction

" nnoremap t<c-t> :call Pytest()<cr>

