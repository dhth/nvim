" let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'

let g:gruvbox_invert_selection='0'

let g:airline_theme = "gruvbox8"

" set background=dark
if strftime("%H") >= 7 && strftime("%H") < 17
    set background=light
else
    set background=dark
endif
colorscheme gruvbox8
" colorscheme kanagawa
