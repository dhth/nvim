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

function! GetFileName(str)
    let l:stripped_str = substitute(a:str, ':', '', 'g')
    let l:stripped_str = substitute(l:stripped_str, ',', '', 'g')
    return substitute(l:stripped_str, ' ', '-', 'g')
endfunction

function! wiki#WriteHeadingInFile(file_loc, str, create_subpages_heading)
    execute "normal! :tabe ".a:file_loc."\<cr>"
    execute "normal! i---\<cr>title: \"".a:str."\"\<cr>summary: \<cr>---\<cr>\<esc>"
    execute "normal! o".a:str."\<esc>"
    execute "normal! o===\<cr>\<cr>\<esc>"
    if a:create_subpages_heading
        execute "normal! iModules\<cr>---\<cr>\<esc>"
    endif
endfunction

function! wiki#AddMarkdownLink()
    call inputsave()
    let link_address = input('Enter link address: ')
    call inputrestore()
    call inputsave()
    let link_title = input('Enter link title: ')
    call inputrestore()
    execute "normal! o\<esc>I- [:fontawesome-solid-link: ".link_title."](".link_address.")"
    echon ''
endfunction

function! wiki#CreateFileLink()
    " Personal utility to quickly generate markdown link
    " to a new file
    let curline = getline('.')
    call inputsave()
    let file_name_in = input('Enter file name: ')
    call inputrestore()
    call inputsave()
    let l:prefix = input('File Prefix: ')
    call inputrestore()
    let l:title_prefix = input('Title Prefix: ')
    call inputrestore()

    " let l:file_title = TwiddleCase(file_name_in)
    if empty(l:title_prefix)
        let l:file_title = file_name_in
    else
        let l:file_title = l:title_prefix.": ".file_name_in
    endif
    let l:dir_loc = expand("%:h")
    if empty(l:prefix)
        let l:file_name = GetFileName(tolower(file_name_in)).".md"
    else
        let l:file_name = l:prefix."-".GetFileName(tolower(file_name_in)).".md"
    endif
    let l:file_loc = l:dir_loc."/".l:file_name

    execute "normal! o\<esc>I- [:fontawesome-solid-file-alt: ".l:file_title."](".l:file_name.")"
    call wiki#WriteHeadingInFile(l:file_loc, l:file_title, 0)
endfunction

function! wiki#CreateDateFileLink()
    " Personal utility to quickly generate markdown link
    " to a new file

    " let l:file_title = TwiddleCase(file_name_in)
    let l:file_name = tolower(strftime('%Y-%m-%d-%A-%B').'.md')
    let l:file_title = strftime('%a, %b %d, %Y')
    let l:dir_loc = expand("%:h")
    let l:file_loc = l:dir_loc."/".l:file_name

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
    let l:dir_name = GetFileName(tolower(file_name_in))

    let l:dir_loc = expand("%:h")."/".l:dir_name
    let l:file_name = l:dir_loc."/index.md"

    execute "normal! o\<esc>I- [:fontawesome-solid-folder: ".l:file_title."](".l:dir_name."/index.md)"
    call wiki#CreateDirectory(l:dir_loc)
    call wiki#WriteHeadingInFile(l:file_name, l:file_title, 1)
endfunction

function! wiki#EnterKeyActions(line_str)
    " If current line contains a link to a markdown page, open that page in a new tab
    " If current line contains a markdown checklist, toggle checkmark
    let l:page_link_str = ']('
    let l:checklist_ticked = '[x]'
    let l:checklist_unticked = '[ ]'
    if stridx(a:line_str, l:checklist_ticked) > -1
        s/\[x\]/\[ \]
    elseif stridx(a:line_str, l:checklist_unticked) > -1
        s/\[ \]/\[x\]
    elseif stridx(a:line_str, l:page_link_str) > -1
        execute "normal! 0f]\<C-W>gf"
    endif
endfunction

function! wiki#GoToFileInNewTab(line_str)
    execute "normal! 0f(\<C-W>gf"
endfunction

function! wiki#CreateBookTrackerRow()
    setl nowrap
    setl textwidth=0
    call inputsave()
    let l:book_name = input('Book name: ')
    call inputrestore()
    call inputsave()
    let l:book_link = input('Book link: ')
    call inputrestore()
    call inputsave()
    let l:book_topic = input('Book topic: ')
    call inputrestore()
    let l:book_topic = trim(l:book_topic)
    call inputsave()
    let l:status = input('Book status (r, tr, ip): ')
    call inputrestore()
    let l:status_dict = {
                \'r': '`R`',
                \'tr': '`TR`',
                \'ip': '`IP`'}
    if len(l:book_link) > 0
        execute "normal! o|[".l:book_name."](".l:book_link.") | `"l:book_topic."`| ".l:status_dict[l:status]."|"
    else
        execute "normal! o|".l:book_name."| `"l:book_topic."` | ".l:status_dict[l:status]."|"
    endif
endfunction

function! wiki#AddQuestion()
    execute "normal! o\rI- [ ] "
endfunction

function! wiki#AddAnswer()
    execute "normal! o\r> "
endfunction

function! s:WikiHelperCommandToRun(command)
    if a:command ==? "Add question"
        call wiki#AddQuestion()
    elseif a:command ==? "Add answer"
        call wiki#AddAnswer()
    elseif a:command ==? "Add link"
        call wiki#AddMarkdownLink()
    elseif a:command ==? "Add log"
        call wiki#CreateDateFileLink()
    endif
endfunction

function! wiki#Helpers()
    let l:commands = ["Add question", "Add answer",  "Add link", "Add log"]
    return fzf#run({'source': l:commands, 'sink': function('s:WikiHelperCommandToRun'),  'window': { 'width': 0.3, 'height': 0.3 } })
endfunction
