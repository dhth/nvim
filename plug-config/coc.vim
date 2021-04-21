"from https://www.youtube.com/watch?v=-I1b8BINyEw
nnoremap <silent> <leader>ff :call CocAction('jumpDefinition')<CR>
nnoremap <silent> <leader>gr :call CocAction('jumpReferences')<CR>
nnoremap <silent> <leader>jj :call CocAction('jumpDefinition', 'tabe')<CR>
nnoremap <silent> <leader>gv :call CocAction('jumpDefinition', 'vnew')<CR>
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>qf  <Plug>(coc-fix-current)

""Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <silent> gy <Plug>(coc-type-definition)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" nnoremap <silent> <c-e> :CocCommand explorer<CR>
nnoremap <silent> <leader>si :call CocAction('runCommand', 'python.sortImports')<cr>
