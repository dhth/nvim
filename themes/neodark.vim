colorscheme neodark
set background=dark

let g:airline_theme='neodark'
let g:neodark#background = '#202020'
let g:neodark#use_256color = 1

" https://vi.stackexchange.com/questions/10897/how-do-i-customize-vimdiff-colors
hi DiffAdd      gui=none    guifg=#1F2F38          guibg=#84B97C
hi DiffChange   gui=none    guifg=none             guibg=none
hi DiffDelete   gui=bold    guifg=#1F2F38          guibg=#DC657D
hi DiffText     gui=bold    guifg=#1F2F38          guibg=#D4B261
