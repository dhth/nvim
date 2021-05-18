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
    execute "normal! i---\<cr>title: \"".a:str."\"\<cr>summary:\<cr>---\<cr>\<esc>"
    execute "normal! o".a:str."\<esc>"
    execute "normal! o===\<cr>\<cr>\<esc>"
    if a:create_subpages_heading
        execute "normal! iModules\<cr>---\<cr>\<esc>"
    endif
endfunction

function! wiki#AddMarkdownLink(link_prefix)
    call inputsave()
    let link_address = input('Enter link address: ')
    call inputrestore()
    call inputsave()
    let link_title = input('Enter link title: ')
    call inputrestore()
    execute "normal! o\<esc>I- [" . a:link_prefix . " " . link_title."](" . link_address.")"
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

function! wiki#AddTodo()
    execute "normal! oI- [ ] "
endfunction

function! wiki#AddAnswer()
    execute "normal! o\r> "
endfunction

function! s:WikiHelperCommandToRun(command)
    if a:command ==? "Add file"
        call wiki#CreateFileLink()
    elseif a:command ==? "Add directory"
        call wiki#CreateFolderLink()
    elseif a:command ==? "Add todo"
        call wiki#AddTodo()
    elseif a:command ==? "Add question"
        call wiki#AddQuestion()
    elseif a:command ==? "Add answer"
        call wiki#AddAnswer()
    elseif a:command ==? "Add link"
        call wiki#CreateLink()
    elseif a:command ==? "Add log"
        call wiki#CreateDateFileLink()
    elseif a:command ==? "Code block"
        call wiki#MakeLineCodeBlock()
    endif
endfunction

function! s:WikiCreateLinkHelperCommandToRun(link_type)
    if a:link_type ==? "Regular"
        let l:link_prefix = ":fontawesome-solid-link:"
    elseif a:link_type ==? "Github"
        let l:link_prefix = ":fontawesome-brands-github:"
    elseif a:link_type ==? "AWS"
        let l:link_prefix = ":fontawesome-brands-aws:"
    elseif a:link_type ==? "Stack Overflow"
        let l:link_prefix = ":fontawesome-brands-stack-overflow:"
    elseif a:link_type ==? "Video"
        let l:link_prefix = ":fontawesome-solid-play-circle:"
    elseif a:link_type ==? "Book"
        let l:link_prefix = ":fontawesome-solid-book:"
    endif
    call wiki#AddMarkdownLinkV2(l:link_prefix)
endfunction

function! wiki#CreateLink()
    let l:commands = [
                \"Regular",
                \"Github",
                \"AWS",
                \"Stack Overflow",
                \"Video",
                \"Book",
                \]
    return fzf#run({'source': l:commands, 'sink': function('s:WikiCreateLinkHelperCommandToRun'),  'window': { 'width': 0.2, 'height': 0.4 } })
endfunction

function! wiki#Helpers()
    let l:commands = [
                \"Add file",
                \"Add link",
                \"Add directory",
                \"Add todo",
                \"Add question",
                \"Add answer",
                \"Add log",
                \"Code block",
                \]
    return fzf#run({'source': l:commands, 'sink': function('s:WikiHelperCommandToRun'),  'window': { 'width': 0.3, 'height': 0.5 } })
endfunction

function! wiki#MakeLineCodeBlock()
    execute "normal! O```jo```k"
endfunction


function! s:OpenWikiPageInBrowser(file)
    let l:resource = split(split(a:file, ".md")[0], "/index")[0]
    silent execute "!open http://127.0.0.1:8000/".l:resource."/"
endfunction


function! s:OpenWorkWikiPageInBrowser(file)
    let l:resource = split(split(a:file, ".md")[0], "/index")[0]
    silent execute "!open http://127.0.0.1:8001/".l:resource."/"
endfunction


function! wiki#OpenWikiPageInBrowser()
    call fzf#run(fzf#wrap({'source': 'fd -p -t f --base-directory=$WIKI_DIR/docs', 'sink': function('s:OpenWikiPageInBrowser')}))
endfunction


function! wiki#OpenWorkWikiPageInBrowser()
    call fzf#run(fzf#wrap({'source': 'fd -p -t f --base-directory=$WORK_WIKI_DIR/docs', 'sink': function('s:OpenWorkWikiPageInBrowser')}))
    " find a way to send arguments to sink function
endfunction


function! wiki#OpenCurrentWikiPageInBrowser()
    let l:file = split(expand('%:p'), "docs/")[-1]
    if stridx(expand('%:p'), $WIKI_DIR) == 0
        call s:OpenWikiPageInBrowser(l:file)
    elseif stridx(expand('%:p'), $WORK_WIKI_DIR) == 0
        call s:OpenWorkWikiPageInBrowser(l:file)
    endif
endfunction

function! wiki#AddMarkdownLinkV2(link_prefix)
    " adds links as a markdown references,
    " requires a <!-- Links --> line below
    " the current line
    let l:current_line_num = line('.')
    let curline = getline('.')
    call inputsave()
    let link_address = input('Enter link address: ')
    call inputrestore()
    call inputsave()
    let link_title = input('Enter link title: ')
    call inputrestore()

    " let l:line_above = getline(l:current_line_num - 1)
    let l:last_link_index = matchstr(l:curline, '.*\]\[\zs.*\ze\]')
    if l:last_link_index
        let l:new_index_number = l:last_link_index + 1
    else
        let l:new_index_number = 1
    endif
    execute "normal! o\<esc>I- [" . a:link_prefix . " " . link_title."][" . l:new_index_number."]"

    " https://stackoverflow.com/questions/56475817/vimscript-execute-search-does-not-work-anymore
    let @/ = 'Links'
    execute "normal! /\<cr>}O[".l:new_index_number."]: ".link_address
    echon ''
    execute l:current_line_num + 1
endfunction
