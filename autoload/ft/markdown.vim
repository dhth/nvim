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
