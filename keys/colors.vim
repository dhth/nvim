set t_Co=256
set termguicolors

"custom commands
" :command! LT set background=light
" :command! DT set background=dark

" VIMCOLORSSTART

" if strftime("%H") >= 7 && strftime("%H") < 17
"     set background=light
" else
"     set background=dark
" endif
        
" set background=dark
" VIMCOLORSEND

"from https://www.youtube.com/watch?v=q7gr6s8skt0
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

"SECTIONBACKGROUNDSTART
"
" if strftime("%H") >= 7 && strftime("%H") < 17
"     set background=light
" else
"     set background=dark
" endif

"SECTIONBACKGROUNDEND

" source $HOME/.config/nvim/themes/gruvbox.vim
" source $HOME/.config/nvim/themes/neodark.vim

" let g:airline_theme='neodark'
" let g:neodark#background = '#202020'
" let g:neodark#use_256color = 1
"
" lua << EOF
" require('github-theme').setup({
"     theme_style = "light",
" })
" EOF
