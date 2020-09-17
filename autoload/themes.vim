function! s:ChangeColors(theme)
    if a:theme ==? "gruvbox-light"
        set background=light
        colorscheme gruvbox
    elseif a:theme ==? "gruvbox-dark"
        set background=dark
        colorscheme gruvbox
    elseif a:theme ==? "neodark"
        set background=dark
        source ~/.config/nvim/themes/neodark.vim 
        AirlineRefresh
    endif
endfunction

function! themes#ChangeColorsPopUp()
    let l:theme_options = ["gruvbox-light", "gruvbox-dark", "neodark"]
    return fzf#run({'source': l:theme_options, 'sink':function('s:ChangeColors'),  'window': { 'width':0.2, 'height': 0.3 } })
endfunction

