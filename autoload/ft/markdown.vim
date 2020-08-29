function! ft#markdown#ToggleCocSuggestions()
    let b:coc_suggestions_turned_off = get(b:, 'coc_suggest_disable', 0)
    if b:coc_suggestions_turned_off
        let b:coc_suggest_disable = 0
    else
        let b:coc_suggest_disable = 1
    endif
endfunction
