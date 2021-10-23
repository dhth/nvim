"https://youtu.be/u6EKq6z0CRU?t=1520
if !exists('*dhth#save_and_exec')
  function! dhth#save_and_exec() abort
    if &filetype == 'vim'
      :silent! write
      :source %
    elseif &filetype == 'lua'
      :silent! write
      :luafile %
    endif

    return
  endfunction
endif
