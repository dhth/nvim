setlocal colorcolumn=80
setlocal nowrap
nnoremap <buffer> <silent> <ENTER> :call wiki_foam#EnterKeyActions(getline('.'))<cr>
vnoremap <buffer> <silent> <ENTER> :lua require("custom.helpers.wiki").toggle_visual_checklist()<CR>
vnoremap <buffer> <silent> aq :lua require("custom.helpers.wiki").quotify_visual()<CR>
nnoremap <buffer> <silent> <leader>st :lua require("custom.helpers.wiki").search_for_tags()<CR>

nnoremap <buffer> <silent> <leader><ENTER> :call wiki_foam#GoToFileInNewTab(getline('.'))<cr>
nnoremap <buffer> <leader>/ :Toc<CR>
nnoremap <buffer> <leader>tf :TableFormat<CR>
" nnoremap <buffer> <leader>- o<esc>I- 
nnoremap <buffer> <leader>- o---<esc>k0i
nnoremap <buffer> <leader>x o<esc>I- [ ] 
set tw=80

nnoremap <buffer> <silent> <leader>oo :call wiki#OpenFileAndEnterText(expand("%:h")."/".expand("<cfile>"), expand("<cfile>"))<cr>
nnoremap <buffer> <silent> <leader>cfl :call wiki_foam#CreateFileLink()<cr>
nnoremap <buffer> <silent> <leader>cdl :call wiki_foam#CreateFolderLink()<cr>

nnoremap <buffer> <leader>ctr :call wiki#CreateBookTrackerRow()<cr>

nnoremap <buffer> <silent> <leader>al :call wiki#AddMarkdownLink()<cr>
nnoremap <buffer> <silent> <leader>cl :call wiki_foam#CreateLinkToAnotherFile()<cr>
inoremap <buffer> <silent> [[ <Esc>:call wiki_foam#CreateLinkToAnotherFile()<cr>

nnoremap <buffer> <silent> <leader>ce :call wiki#CreateDateFileLink()<cr>
nnoremap <buffer> <silent> <leader>aq :call wiki#AddQuestion()<cr>
nnoremap <buffer> <silent> <leader>bl :call wiki_foam#GetBacklinks()<cr>
nnoremap <buffer> <silent> [[ :call wiki_foam#GetBacklinks()<cr>
nnoremap <buffer> <silent> <leader>le :call wiki_foam#AddQuestion()<cr>
nnoremap <buffer> <silent> <leader>te :call wiki_foam#AddQuestion()<cr>

nnoremap <silent> <leader>he :call wiki_foam#Helpers()<cr>

nnoremap <silent> <leader>ow :call wiki_foam#OpenCurrentWikiPageInBrowser()<cr>

nnoremap <buffer> <leader>mr :call ft#markdown#ToggleMarkdownRender()<cr>

vnoremap <buffer> <silent> fm :'<,'>!jq<CR>

vnoremap <buffer> <silent> cl :lua require("custom.helpers.wiki").add_visual_checklist()<CR>

vnoremap <buffer> <silent> ml :lua require("custom.helpers.wiki").add_visual_list()<CR>

nnoremap <silent><leader>ad :call helpers#AddDate()<cr>
inoremap <buffer> <silent> [t <Esc>:call wiki_foam#AddFoamLinkToTodaysLog()<cr>

nnoremap <buffer> <silent> <leader>sl :lua require("custom.helpers.wiki").open_current_pages_webview()<CR>

inoremap <buffer> <silent> [r <Esc>:lua require("custom.helpers.wiki").reference_existing_link()<CR>

vnoremap <buffer> <c-t> :lua require("custom.helpers.wiki").open_urls()<CR>
nnoremap <buffer> <silent> f<c-f> :lua require("custom.helpers.code.general").format_code_block()<CR>

nmap <silent> `` ysiw`
nnoremap <buffer> <leader>al :lua require("custom.helpers.code.general").add_link_to_md()<CR>

inoremap <buffer> <silent> ][ <cmd>lua require("custom.telescope").enter_file_path()<CR>
