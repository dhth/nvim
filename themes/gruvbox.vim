colorscheme gruvbox

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'medium'

if strftime("%H") < 20
  set background=light
else
  set background=dark
endif

"from https://www.youtube.com/watch?v=q7gr6s8skt0
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

