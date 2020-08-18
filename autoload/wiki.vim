function! wiki#CreateDirectory(new_dir)
    execute "silent !mkdir -p ".a:new_dir
endfunction

function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
        let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
        let result = toupper(a:str)
    endif
    return result
endfunction

function! ReplaceSpacesWithDashes(str)
    return substitute(a:str, ' ', '-', 'g')
endfunction

function! wiki#WriteHeadingInFile(file_loc, str, create_subpages_heading)
    execute "normal! :tabe ".a:file_loc."\<cr>"
    execute "normal! i".a:str."\<esc>"
    execute "normal! o===\<cr>\<cr>\<esc>"
    if a:create_subpages_heading
        execute "normal! iModules\<cr>---\<cr>\<esc>"
    endif
endfunction

function! wiki#CreateFileLink()
    " Personal utility to quickly generate markdown link
    " to a new file
    let curline = getline('.')
    call inputsave()
    let file_name_in = input('Enter file name: ')
    call inputrestore()

    " let l:file_title = TwiddleCase(file_name_in)
    let l:file_title = file_name_in
    let l:dir_loc = expand("%:h")
    let l:file_name = ReplaceSpacesWithDashes(tolower(file_name_in)).".md"
    let l:file_loc = l:dir_loc."/".ReplaceSpacesWithDashes(tolower(file_name_in)).".md"

    execute "normal! o\<esc>I- [:fontawesome-solid-file-alt: ".l:file_title."](".l:file_name.")"
    call wiki#WriteHeadingInFile(l:file_loc, l:file_title, 0)
endfunction

function! wiki#CreateFolderLink()
    " Personal utility to quickly generate markdown link
    " to a new file in a new directory
    let curline = getline('.')
    call inputsave()
    let file_name_in = input('Enter folder name: ')
    call inputrestore()

    " let l:file_title = TwiddleCase(file_name_in)
    let l:file_title = file_name_in
    let l:dir_name = ReplaceSpacesWithDashes(tolower(file_name_in))

    let l:dir_loc = expand("%:h")."/".l:dir_name
    let l:file_name = l:dir_loc."/index.md"

    execute "normal! o\<esc>I- [:fontawesome-solid-folder: ".l:file_title."](".l:dir_name."/index.md)"
    call wiki#CreateDirectory(l:dir_loc)
    call wiki#WriteHeadingInFile(l:file_name, l:file_title, 1)
endfunction
