set textwidth=0

function! s:PyHelperCommandToRun(command)
    if a:command ==? "__init__"
        let l:new_file = expand('%:p:h').'/__init__.py'
        silent execute '!touch ' . l:new_file
    elseif a:command ==? "lint"
        Dispatch $HOME/.virtualenvs/general/bin/pylint $(pwd)
    elseif a:command ==? "black"
        Dispatch $HOME/.virtualenvs/general/bin/black $(pwd)
    elseif a:command ==? "isort"
        Dispatch $HOME/.virtualenvs/general/bin/isort $(pwd)
    endif
endfunction

function! ft#python#Helpers()
    let l:commands = [
                \"black",
                \"lint",
                \"isort",
                \"__init__", 
                \]
    return fzf#run({'source': l:commands, 'sink': function('s:PyHelperCommandToRun'),  'window': { 'width': 0.2, 'height': 0.3 } })
endfunction
