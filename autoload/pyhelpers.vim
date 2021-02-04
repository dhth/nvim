function! s:PyHelperCommandToRun(command)
    if a:command ==? "lint"
        Dispatch /Users/dhruvthakur/.virtualenvs/general/bin/pylint $(pwd)
    elseif a:command ==? "black"
        Dispatch /Users/dhruvthakur/.virtualenvs/general/bin/black $(pwd)
    elseif a:command ==? "isort"
        Dispatch /Users/dhruvthakur/.virtualenvs/general/bin/isort $(pwd)
    endif
endfunction

function! pyhelpers#PyHelpers()
    let l:commands = ["black", "lint", "isort"]
    return fzf#run({'source': l:commands, 'sink': function('s:PyHelperCommandToRun'),  'window': { 'width': 0.2, 'height': 0.4 } })
endfunction

" nnoremap t<c-t> :call Pytest()<cr>

