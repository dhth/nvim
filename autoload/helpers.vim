function! s:CreateFileHelper(command)
    call inputsave()
    let l:file_name_in = input('Enter file name: ')
    call inputrestore()
    if len(l:file_name_in) > 0
        execute "new ".a:command."/".l:file_name_in
        write
    endif
endfunction


function! helpers#CreateFile()
    call fzf#run(fzf#wrap({'source': 'fd -H -t d', 'sink': function('s:CreateFileHelper')}))
endfunction


function! helpers#AddDate()
    let l:date = system("date '+%Y-%m-%d' | tr -d '\n'")
    execute 'normal! a ' . l:date
endfunction

function! helpers#LocalNotes()
    " let l:project_root = trim(system("git rev-parse --show-toplevel"))
    " echo l:project_root."/local_wiki.md"
    " execute "new " . l:project_root ."/local_wiki.md"
    new local_wiki.md
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
    new a:address
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
