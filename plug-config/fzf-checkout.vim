nnoremap g<c-g> :GBranches<CR>

let g:fzf_branch_actions = {
      \ 'diff': {
      \   'prompt': 'Diff> ',
      \   'execute': 'Git diff {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-f',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \   'track': {'keymap': 'ctrl-t'},
      \ },
      \}
