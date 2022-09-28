"from https://www.youtube.com/watch?v=-I1b8BINyEw
" nnoremap <C-p> :GFiles<CR>

"for FZF files
nnoremap <silent> <c-f> :Files<CR>

nnoremap <Leader>ps :Rg --hidden --iglob='!.git/' -F<SPACE>
" nnoremap <leader>sw :Rg --hidden --iglob='!.git/'<SPACE><c-r><c-w><cr>
nnoremap <silent> <Leader>bs :Lines<CR>
nnoremap <silent> <c-p> :History<CR>
nnoremap <silent> <Leader>ch :History:<CR>
" nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> g<c-g> :Windows<CR>
" nnoremap <silent> <C-s> :BLines<CR>
" nnoremap <silent> <leader><C-g> :GFiles?<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif

" let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" let g:fzf_layout = { 'down': '30%' }

" from https://github.com/junegunn/fzf.vim#advanced-customization
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --iglob="!.git/" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" nnoremap <Leader>l :RG<CR>

" nnoremap <leader>vv :FZF ~/.config/nvim<CR>

let g:fzf_preview_window = ''

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tabedit',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! SearchDockerComposeFiles call fzf#run(fzf#wrap({'source': "fd -ipH -t f '.*docker.*.yml'"}))

" nnoremap <leader>lo <cmd>call fzf#run(fzf#wrap({'source': "fd -ipH -t f 'local_only.*'"}))<CR>
" nnoremap <leader>dkf <cmd>call fzf#run(fzf#wrap({'source': "fd -ipH -t f '.*Dockerfile.*'"}))<CR>

let g:fzf_buffers_jump = 1

let g:fzf_commits_log_options = '--all --color --graph --pretty=format:''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'' --abbrev-commit'
