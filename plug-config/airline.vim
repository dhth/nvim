" +-----------------------------------------------------------------------------+
" | A | B |                     C                            X | Y | Z |  [...] |
" +-----------------------------------------------------------------------------+

" section # meaning (example)
" A       # displays the mode + additional flags like crypt/spell/paste (INSERT)
" B       # VCS information - branch, hunk summary (master)
" C       # filename + read-only flag (~/.vim/vimrc RO)
" X       # filetype (vim)
" Y       # file encoding[fileformat] (utf-8[unix])
" Z       # current position in the file
" [...]   # additional sections (warning/errors/statistics) from external
"         # plugins (e.g. YCM, syntastic, ...)

"show airline tab line
let g:airline#extensions#tabline#enabled = 1

"don't show buffers in airline tab bar
let g:airline#extensions#tabline#show_splits = 0

"shorter tab names
let g:airline#extensions#tabline#formatter = 'unique_tail'

"don't display tab count on the right side
let g:airline#extensions#tabline#show_tab_count = 0

"show tab number
let g:airline#extensions#tabline#tab_nr_type = 1

let g:airline_section_b=''
let g:airline_section_x=''
let g:airline_section_y=''

let g:airline_skip_empty_sections = 1

" don't show hunk status
let g:airline#extensions#hunks#enabled=0
