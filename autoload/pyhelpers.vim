function! s:PyHelperCommandToRun(command)
    if a:command ==? "lint"
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
    endif
endfunction

function! pyhelpers#PyHelpers()
    let l:commands = ["black", "lint", "isort", "get staged files", "add recently modified links", "lcd nvim"]
    return fzf#run({'source': l:commands, 'sink': function('s:PyHelperCommandToRun'),  'window': { 'width': 0.4, 'height': 0.4 } })
endfunction

" nnoremap t<c-t> :call Pytest()<cr>

