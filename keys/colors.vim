"custom commands
:command! LT set background=light
:command! DT set background=dark

if strftime("%H") > 8 && strftime("%H") < 14
  set background=light
  colorscheme gruvbox
else
  set background=dark
  colorscheme nightfly
endif
" set background=dark
" colorscheme sonokai

"from https://www.youtube.com/watch?v=q7gr6s8skt0
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
