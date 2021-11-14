local opts = { noremap=true, silent=true }

REMAP(
    'n',
    '<Leader>df',
    ':DiffviewOpen<space>',
    { noremap=true, silent=false }
)

REMAP(
    'n',
    '<Leader>fh',
    ':DiffviewFileHistory<CR>',
    opts
)
