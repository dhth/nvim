function! s:HelperCommandToRun(command)
    let l:command = 'just --justfile ~/.global.justfile --working-directory . ' . a:command
    execute "Dispatch " . l:command
endfunction


function! just_helpers#Helpers()
    let l:just_commands = split(trim(system("cat ~/.global.justfile justfile 2>/dev/null | grep ':$' | awk -F \":\" '// {print $1}'| awk '!seen[$0]++'")))
    return fzf#run({'source': l:just_commands, 'sink': function('s:HelperCommandToRun'),  'window': { 'width': 0.3, 'height': 0.6 } })
endfunction


function! s:GitHelperCommandToRun(command)
    execute a:command
endfunction


function! just_helpers#GitHelpers()
    let l:git_commands = split(trim(system("cat ~/.global.gitfile")), "\n")
    return fzf#run({'source': l:git_commands, 'sink': function('s:GitHelperCommandToRun'), 'window': { 'width': 0.3, 'height': 0.5 } })
endfunction
