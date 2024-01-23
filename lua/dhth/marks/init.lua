require 'marks'.setup {
    default_mappings = false,
    refresh_interval = 1000,
    mappings = {
        set_next = "ma",
        next = "]1",
        prev = "[1",
        delete_line = "dm",
        delete_buf = "dm<space>",
    }
}

local opts = { noremap = true, silent = true }

REMAP(
    'n',
    '<leader>ms',
    '<cmd>MarksQFListBuf<CR>',
    opts
)
