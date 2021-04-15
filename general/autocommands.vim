" if exists('##TextYankPost')
"     autocmd TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank('Substitute', 200)
" endif
