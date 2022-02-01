" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitBranchName()
    let branch_name = systemlist('git rev-parse --abbrev-ref HEAD')
    return map(branch_name, "{'line': v:val}")
endfunction

function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitStaged()
    let files = systemlist('git diff --cached --name-only 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': function('s:gitBranchName'),  'header': ['   branch']},
        \ { 'type': function('s:gitStaged'),  'header': ['   staged']},
        \ { 'type': function('s:gitModified'),  'header': ['   modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   untracked']},
        \ ]

let g:startify_change_to_dir = 0
