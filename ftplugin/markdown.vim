setlocal colorcolumn=80
nnoremap <buffer> <leader>ml f]gf
" nnoremap <buffer> <ENTER> 0f]<C-W>gf
nnoremap <buffer> <silent> <ENTER> :call wiki_foam#EnterKeyActions(getline('.'))<cr>
vnoremap <buffer> <silent> <ENTER> :lua require("dhth.wiki_helpers").toggle_visual_checklist()<CR>
vnoremap <buffer> <silent> aq :lua require("dhth.wiki_helpers").quotify_visual()<CR>

nnoremap <buffer> <silent> <leader><ENTER> :call wiki#GoToFileInNewTab(getline('.'))<cr>
" augroup mdtoc
"     autocmd BufRead * Toc
" augroup END
" Open TOC and switch back to left window
" Toc
" wincmd h
nnoremap <buffer> <leader>/ :Toc<CR>
nnoremap <buffer> <leader>tf :TableFormat<CR>
" nnoremap <buffer> <leader>- o<esc>I- 
nnoremap <buffer> <leader>- o---<esc>k0i
nnoremap <buffer> <leader>x o<esc>I- [ ] 
set tw=80
" set foldmethod=syntax
nnoremap <buffer> <silent> <leader>oo :call wiki#OpenFileAndEnterText(expand("%:h")."/".expand("<cfile>"), expand("<cfile>"))<cr>
nnoremap <buffer> <silent> <leader>cfl :call wiki_foam#CreateFileLink()<cr>
nnoremap <buffer> <silent> <leader>cdl :call wiki_foam#CreateFolderLink()<cr>

nnoremap <buffer> <leader>ctr :call wiki#CreateBookTrackerRow()<cr>

" nnoremap <buffer> <silent> <leader>tc :call ft#markdown#ToggleCocSuggestions()<cr>
" nnoremap <buffer> <silent> <leader>tc :call ft#markdown#ToggleCocSources()<cr>
nnoremap <buffer> <silent> <leader>al :call wiki#AddMarkdownLink()<cr>
nnoremap <buffer> <silent> <leader>cl :call wiki_foam#CreateLinkToAnotherFile()<cr>
nnoremap <buffer> <silent> <leader>ce :call wiki#CreateDateFileLink()<cr>
nnoremap <buffer> <silent> <leader>aq :call wiki#AddQuestion()<cr>
nnoremap <buffer> <silent> <leader>aa :call wiki#AddAnswer()<cr>
nnoremap <buffer> <silent> <leader>bl :call wiki_foam#GetBacklinks()<cr>

nnoremap <silent> f<c-f> :call wiki_foam#Helpers()<cr>
inoremap <silent> f<c-f> <Esc>:call wiki_foam#Helpers()<cr>

nnoremap <silent> <leader>ow :call wiki_foam#OpenCurrentWikiPageInBrowser()<cr>

setlocal foldenable
" setlocal fo-=q
" setlocal formatoptions-=q
" set formatoptions=tcqln
" set comments=fb:*,fb:-,fb:+,n:>
" 
" This will disable most suggestions
" snippets will still be suggested
" call CocAction('toggleSource', 'around')
" call CocAction('toggleSource', 'buffer')

nnoremap <buffer> <silent> <leader><enter> :call ft#markdown#GlowViaVimux()<cr>

nnoremap <buffer> <leader>mr :call ft#markdown#ToggleMarkdownRender()<cr>

vnoremap <buffer> <silent> fm :'<,'>!jq<CR>
