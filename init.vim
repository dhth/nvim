source $HOME/.config/nvim/vim-plug/plugins.vim
" lua require('plugins')
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/tabs.vim
source $HOME/.config/nvim/general/folds.vim
source $HOME/.config/nvim/general/highlights.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/keys/colors.vim
" source $HOME/.config/nvim/themes/gruvbox.vim
source $HOME/.config/nvim/general/netrw.vim
source $HOME/.config/nvim/plug-config/fzf.vim
" source $HOME/.config/nvim/plug-config/fzf-checkout.vim
" source $HOME/.config/nvim/plug-config/coc.vim
" source $HOME/.config/nvim/plug-config/auto-pairs.vim
source $HOME/.config/nvim/plug-config/fugitive.vim
source $HOME/.config/nvim/plug-config/vim-flog.vim
source $HOME/.config/nvim/plug-config/vim-sneak.vim
" source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/vim-markdown.vim
" source $HOME/.config/nvim/plug-config/signify.vim
source $HOME/.config/nvim/plug-config/vimux.vim
source $HOME/.config/nvim/plug-config/vim-test.vim
source $HOME/.config/nvim/plug-config/vim-easy-align.vim
source $HOME/.config/nvim/plug-config/vim-bookmarks.vim
" source $HOME/.config/nvim/plug-config/which-key.vim
source $HOME/.config/nvim/plug-config/todo-comments.vim
source $HOME/.config/nvim/plug-config/nnn.vim
" source $HOME/.config/nvim/plug-config/octo-nvim.vim
source $HOME/.config/nvim/plug-config/vim-startify.vim
lua require('dhth')
source $HOME/.config/nvim/plug-config/telescope.vim

" augroup markdown_glow
"     autocmd!
"     autocmd BufWritePost,BufWinEnter *.md call ft#markdown#GlowViaVimux()
" augroup END
"
