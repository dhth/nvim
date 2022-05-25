function! wiki_foam#CreateDirectory(new_dir)
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
    let l:stripped_str = substitute(l:stripped_str, '@', '', 'g')
    let l:stripped_str = substitute(l:stripped_str, '_', '', 'g')
    return substitute(l:stripped_str, ' ', '-', 'g')
endfunction

function! wiki_foam#WriteHeadingInFile(file_loc, str, create_subpages_heading)
    execute "vnew ".a:file_loc
    " execute "normal! :tabe ".a:file_loc."\<cr>"
    " execute "normal! i---\<cr>title: \"".a:str."\"\<cr>summary:\<cr>---\<cr>\<esc>"
    execute "normal! i".a:str."\<esc>"
    execute "normal! o===\<cr>\<cr>\<esc>"
    " execute "normal! iResources\<cr>---\<cr>\<cr>\<cr><!-- Links -->\<cr>\<cr>\<esc>"
    if a:create_subpages_heading
        execute "normal! iModules\<cr>---\<cr>\<esc>"
    endif
    execute "write"
endfunction

function! wiki_foam#AddMarkdownLink(link_prefix)
    call inputsave()
    let link_address = input('Enter link address: ')
    call inputrestore()
    call inputsave()
    let link_title = input('Enter link title: ')
    call inputrestore()
    execute "normal! o\<esc>I- [" . a:link_prefix . " " . link_title."](" . link_address.")"
    echon ''
endfunction

function! s:PrePad(s,amt,...)
    if a:0 > 0
        let char = a:1
    else
        let char = ' '
    endif
    return repeat(char,a:amt - len(a:s)) . a:s
endfunction

function! wiki_foam#CreateFileLink()
    " Personal utility to quickly generate markdown link
    " to a new file
    let l:current_line_num = line('.')
    let curline = getline('.')
    call inputsave()
    let file_name_in = input('Enter file name: ')
    call inputrestore()
    let l:file_title = file_name_in
    let l:dir_loc = expand("%:h")
    let l:file_name = GetFileName(tolower(file_name_in))
    let l:existing_file = system("fd --glob -t f ".l:file_name.".md")
    if len(l:existing_file) > 0
        echom " - File already exists"
        return
    endif
    let l:file_path = GetFileName(tolower(file_name_in)).".md"
    let l:file_loc = l:dir_loc."/".l:file_path

    execute "normal! o\<esc>I- [[".l:file_name."]]"
    execute "write"
    call wiki_foam#WriteHeadingInFile(l:file_loc, l:file_title, 0)
endfunction

function! wiki_foam#RunJanitor()
    " let l:cwd = getcwd()
    " echom l:cwd
    Dispatch foam janitor $(pwd)
endfunction

function! wiki_foam#CreateDateFileLink()
    " Personal utility to quickly generate markdown link
    " to a new file

    " let l:file_title = TwiddleCase(file_name_in)
    let l:file_name = tolower(strftime('%Y-%m-%d-%A-%B').'.md')
    let l:file_title = strftime('%a, %b %d, %Y')
    let l:dir_loc = expand("%:h")
    let l:file_loc = l:dir_loc."/".l:file_name

    execute "normal! o\<esc>I- [:fontawesome-solid-file-alt: ".l:file_title."](".l:file_name.")"
    execute "only"
    call wiki_foam#WriteHeadingInFile(l:file_loc, l:file_title, 0)
endfunction

function! wiki_foam#CreateFolderLink()
    " Personal utility to quickly generate markdown link
    " to a new file in a new directory
    let curline = getline('.')
    call inputsave()
    let file_name_in = input('Enter folder name: ')
    call inputrestore()

    " let l:file_title = TwiddleCase(file_name_in)
    let l:file_title = file_name_in
    let l:dir_name = GetFileName(tolower(file_name_in))

    let l:existing_file = system("fd --glob -t f ".l:dir_name.".md")
    if len(l:existing_file) > 0
        echom " - File already exists"
        return
    endif

    let l:dir_loc = expand("%:h")."/".l:dir_name
    let l:file_name = l:dir_loc."/".l:dir_name.".md"

    execute "normal! o\<esc>I- [[".l:dir_name."]]"
    call wiki_foam#CreateDirectory(l:dir_loc)
    execute "only"
    execute "write"
    call wiki_foam#WriteHeadingInFile(l:file_name, l:file_title, 1)
endfunction

function! wiki_foam#EnterKeyActions(line_str)
    " If current line contains a link to a markdown page, open that page in a new tab
    " If current line contains a markdown checklist, toggle checkmark
    let l:page_link_str = '[['
    let l:checklist_ticked = '[x]'
    let l:checklist_unticked = '[ ]'
    let l:url = 'https://'
    if stridx(a:line_str, l:checklist_ticked) > -1
        s/\[x\]/\[ \]
    elseif stridx(a:line_str, l:checklist_unticked) > -1
        s/\[ \]/\[x\]
    elseif stridx(a:line_str, l:page_link_str) > -1
        let l:file_name = trim(matchstr(getline('.'), '.*\[\[\zs.*\ze\]\]'))
        let l:existing_file = system("fd --glob -t f ".l:file_name.".md")
        execute "only"
        execute "vnew ".l:existing_file
    elseif stridx(a:line_str, l:url) > -1
        " custom url opener, because gx stopped working for some reason
        " check to see what's failing with gx
        " https://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser
        let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
        echo s:uri
        if s:uri != ""
            silent exec "!open '".s:uri."'"
        else
            echo "No URI found in line."
        endif
        " execute "normal gx"
    endif
endfunction

function! wiki_foam#GoToFileInNewTab(line_str)
    execute "normal! 0f(\<C-W>gf"
endfunction

function! wiki_foam#CreateBookTrackerRow()
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

function! wiki_foam#AddQuestion()
    execute "normal! oI- [ ]  "
    startinsert
endfunction

function! wiki_foam#AddTodo()
    execute "normal! oI- [ ] "
endfunction

function! wiki_foam#AddAnswer()
    execute "normal! o\r> "
endfunction

function! s:WikiHelperCommandToRun(command)
    if a:command ==? "Add file"
        call wiki_foam#CreateFileLink()
    elseif a:command ==? "Foam janitor"
        call wiki_foam#RunJanitor()
    elseif a:command ==? "Add directory"
        call wiki_foam#CreateFolderLink()
    elseif a:command ==? "Add todo"
        call wiki_foam#AddTodo()
    elseif a:command ==? "Add question"
        call wiki_foam#AddQuestion()
    elseif a:command ==? "Add answer"
        call wiki_foam#AddAnswer()
    elseif a:command ==? "Add link"
        call wiki_foam#CreateLink()
    elseif a:command ==? "Add log"
        call wiki_foam#CreateDateFileLink()
    elseif a:command ==? "Code block"
        call wiki_foam#MakeLineCodeBlock()
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
    call wiki_foam#AddMarkdownLinkV2(l:link_prefix)
endfunction

function! wiki_foam#CreateLink()
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

function! wiki_foam#Helpers()
    let l:commands = [
                \"Add file",
                \"Foam janitor",
                \"Add question",
                \"Add directory",
                \"Add link",
                \"Add todo",
                \"Add answer",
                \"Add log",
                \"Code block",
                \]
    return fzf#run({'source': l:commands, 'sink': function('s:WikiHelperCommandToRun'),  'window': { 'width': 0.3, 'height': 0.5 } })
endfunction

function! wiki_foam#MakeLineCodeBlock()
    execute "normal! O```jo```k"
endfunction


function! s:OpenWikiPageInBrowser(file, port)
    let l:resource = split(split(a:file, ".md")[0], "/index")[0]
    silent execute "!open http://127.0.0.1:".a:port."/".l:resource."/"
endfunction


function! wiki_foam#OpenWikiPageInBrowser()
    call fzf#run(fzf#wrap({'source': 'fd -p -t f --base-directory=$WIKI_DIR/docs', 'sink': function('s:OpenWikiPageInBrowser')}))
endfunction


function! wiki_foam#OpenWorkWikiPageInBrowser()
    call fzf#run(fzf#wrap({'source': 'fd -p -t f --base-directory=$WORK_WIKI_DIR/docs', 'sink': function('s:OpenWorkWikiPageInBrowser')}))
    " find a way to send arguments to sink function
endfunction


function! wiki_foam#OpenCurrentWikiPageInBrowser()
    let l:file = expand('%:f')
    if stridx(expand('%:p'), $WIKI_DIR) == 0
        call s:OpenWikiPageInBrowser(l:file, 8000)
    elseif stridx(expand('%:p'), $WORK_WIKI_DIR) == 0
        call s:OpenWikiPageInBrowser(l:file, 8001)
    endif
endfunction

function! wiki_foam#AddMarkdownLinkV2(link_prefix)
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


function! s:CreateMarkdownForLinkToAnotherFile(file_path)
    let l:file_name = split(split(a:file_path, "/")[-1], ".md")[0]
    execute "normal! i[[".l:file_name."]]"
endfunction


function! wiki_foam#CreateLinkToAnotherFile()
    call fzf#run(fzf#wrap({'source': 'fd -t f -e md', 'sink': function('s:CreateMarkdownForLinkToAnotherFile')}))
endfunction


function! wiki_foam#GetBacklinks()
    let l:file_name = split(expand("%:t"), ".md")[0]
    let l:search_str = '\[\['.l:file_name.'\]\]'
    " execute "Rg --hidden --iglob='!.git/' -t md '".l:search_str."'"
    execute "Rg ".l:search_str
endfunction
