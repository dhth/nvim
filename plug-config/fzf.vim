"from https://www.youtube.com/watch?v=-I1b8BINyEw
nnoremap <C-p> :GFiles<CR>

"for FZF files
nnoremap <C-f> :Files<CR>

nnoremap <Leader>ps :Rg<SPACE>
nnoremap <Leader>bs :Lines<CR>
nnoremap <C-h> :History<CR>
nnoremap <leader>bl :BLines<CR>

"repeat same mappings for new tab
nnoremap <Leader><C-p> :tabnew<CR>:GFiles<CR>
nnoremap <Leader><C-f> :tabnew<CR>:Files<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif

let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" from https://github.com/junegunn/fzf.vim#advanced-customization
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <C-l> :RG<CR>
