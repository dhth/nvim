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
    elseif a:theme ==? "github"
        set background=light
        source ~/.config/nvim/themes/github.vim 
    elseif a:theme ==? "nightfly"
        set background=dark
        colorscheme nightfly
    endif
    AirlineRefresh
endfunction

function! themes#ChangeColorsPopUp()
    let l:theme_options = ["gruvbox-light", "gruvbox-dark", "neodark", "github", "nightfly"]
    return fzf#run({'source': l:theme_options, 'sink':function('s:ChangeColors'),  'window': { 'width':0.2, 'height': 0.3 } })
endfunction

