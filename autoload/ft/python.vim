set textwidth=0

function! s:PyHelperCommandToRun(command)
    if a:command ==? "__init__"
        let l:new_file = expand('%:p:h').'/__init__.py'
        silent execute '!touch ' . l:new_file
    elseif a:command ==? "pylint"
        Dispatch $HOME/.virtualenvs/general/bin/pylint $(pwd)
    elseif a:command ==? "flake8"
        Dispatch $HOME/.virtualenvs/general/bin/flake8 $(pwd)
    elseif a:command ==? "black"
        silent execute '!black .'
    elseif a:command ==? "isort"
        silent execute '!isort .'
    endif
endfunction

function! ft#python#Helpers()
    let l:commands = [
                \"black",
                \"lint",
                \"flake8",
                \"isort",
                \"__init__", 
                \]
    return fzf#run({'source': l:commands, 'sink': function('s:PyHelperCommandToRun'),  'window': { 'width': 0.2, 'height': 0.3 } })
endfunction


function! ft#python#AddTestComments()
    execute "normal! o# GIVEN\r# WHEN\r# THEN2k"
endfunction
