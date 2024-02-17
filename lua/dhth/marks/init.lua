require 'marks'.setup {
    default_mappings = false,
    refresh_interval = 1000,
    mappings = {
        set_next = "ma",
        -- next = "]1",
        -- prev = "[1",
        delete_line = "dmm",
        delete_buf = "dm<space>",
        delete_bookmark = "dmb",
        set_bookmark1 = "m1",
        set_bookmark2 = "m2",
        set_bookmark3 = "m3",
        set_bookmark4 = "m4",
        next_bookmark1 = "]1",
        next_bookmark2 = "]2",
        next_bookmark3 = "]3",
        next_bookmark4 = "]4",
        prev_bookmark1 = "[1",
        prev_bookmark2 = "[2",
        prev_bookmark3 = "[3",
        prev_bookmark4 = "[4",
    }
}

local opts = { noremap = true, silent = true }

REMAP(
    'n',
    '<leader>ms',
    '<cmd>MarksQFListBuf<CR>',
    opts
)
