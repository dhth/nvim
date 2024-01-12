require("flash").setup()

REMAP(
    'n',
    's',
    '<cmd>lua require("flash").jump({ search = { multi_window = false }, })<cr>',
    { noremap = true, silent = true }
)

REMAP(
    'o',
    'r',
    '<cmd>lua require("flash").remote({ search = { multi_window = false }, })<cr>',
    { noremap = true, silent = true }
)

REMAP(
    'n',
    'S',
    '<cmd>lua require("flash").treesitter({ search = { multi_window = false }, })<cr>',
    { noremap = true, silent = true }
)
REMAP(
    'x',
    'S',
    '<cmd>lua require("flash").treesitter({ search = { multi_window = false }, })<cr>',
    { noremap = true, silent = true }
)
REMAP(
    'o',
    'S',
    '<cmd>lua require("flash").treesitter({ search = { multi_window = false }, })<cr>',
    { noremap = true, silent = true }
)
REMAP(
    'o',
    'R',
    '<cmd>lua require("flash").treesitter_search()<cr>',
    { noremap = true, silent = true }
)
REMAP(
    'x',
    'R',
    '<cmd>lua require("flash").treesitter_search()<cr>',
    { noremap = true, silent = true }
)
