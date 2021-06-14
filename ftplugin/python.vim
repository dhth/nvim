"run python file in an adjacent tmux pane
nnoremap <leader><cr> :VimuxRunCommand('python '.expand('%'))<CR>

nnoremap <silent> f<c-f> :call ft#python#Helpers()<cr>

setl textwidth=0
