" function! ft#markdown#ToggleCocSuggestions()
"     let b:coc_suggestions_turned_off = get(b:, 'coc_suggest_disable', 0)
"     if b:coc_suggestions_turned_off
"         let b:coc_suggest_disable = 0
"     else
"         let b:coc_suggest_disable = 1
"     endif
" endfunction


" function! ft#markdown#ToggleCocSources()
"     call CocAction('toggleSource', 'around')
" endfunction


function! ft#markdown#BoldListKeys()
    """ Makes the key of the list item (ie, anything before
    """ a colon) bold
    let l:current_line_num = line('.')
    execute ".,$g/^-/norm!f a**\<esc>f:i**"
    execute "noh"
    execute l:current_line_num
endfunction


function! ft#markdown#GlowViaVimux()
    let l:current_file = expand('%')
    VimuxRunCommand('clear; glow -p ' . l:current_file)
endfunction


function! ft#markdown#ToggleMarkdownRender()
    if !exists('#MarkdownGlow#BufWritePost')
        augroup MarkdownGlow
            autocmd!
            autocmd BufWritePost,BufWinEnter *.md call ft#markdown#GlowViaVimux()
            echo "Markdown rendering turned ON"
        augroup END
    else
        augroup MarkdownGlow
            autocmd!
            echo "Markdown rendering turned OFF"
        augroup END
    endif
endfunction

