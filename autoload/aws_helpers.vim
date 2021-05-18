function! s:SearchHelperCommandToRun(command)
    if a:command ==? "cdk api reference"
        let l:c_word = expand("<cword>")
        call fzf#run(fzf#wrap({'source': 'cat $AWS_HELPERS_DIR/cdk/api_reference/lists/cdk_api_reference.txt', 'sink': function('s:OpenCDKRefURL')}))
    elseif a:command ==? "cdk PY api reference"
        let l:c_word = expand("<cword>")
        call fzf#run(fzf#wrap({'source': 'cat $AWS_HELPERS_DIR/cdk/api_reference/lists/cdk_py_api_reference.txt', 'sink': function('s:OpenCDKPyRefURL')}))
    endif
endfunction


function! s:OpenCDKRefURL(line)
    let l:url = trim(split(a:line, ",")[1])
    silent execute "!open " . shellescape("https://docs.aws.amazon.com" . l:url, 1)
endfunction


function! s:OpenCDKPyRefURL(line)
    let l:url = trim(split(a:line, ",")[1])
    silent execute "!open " . shellescape("https://docs.aws.amazon.com/cdk/api/latest/python/".l:url, 1)
endfunction


function! aws_helpers#SearchCDKAPIReferenceForCurrentWord()
    let l:current_file_type = &filetype
    let l:c_word = expand("<cword>")
    if l:current_file_type == "python"
        call fzf#run(fzf#wrap({'source': 'cat $AWS_HELPERS_DIR/cdk/api_reference/lists/cdk_py_api_reference.txt', 'sink': function('s:OpenCDKPyRefURL'), 'options': '-q '.l:c_word}))
    else
        call fzf#run(fzf#wrap({'source': 'cat $AWS_HELPERS_DIR/cdk/api_reference/lists/cdk_api_reference.txt', 'sink': function('s:OpenCDKRefURL'), 'options': '-q '.l:c_word}))
    endif
endfunction


function! aws_helpers#Search()
    let l:commands = [
                \"cdk api reference",
                \"cdk PY api reference",
                \]
    return fzf#run({'source': l:commands, 'sink': function('s:SearchHelperCommandToRun'),  'window': { 'width': 0.3, 'height': 0.5 } })
endfunction
