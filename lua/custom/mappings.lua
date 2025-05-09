NOREMAP_SILENT("n", "<esc>", "<NOP>")

--- inserts a date using external command completion
NOREMAP_SILENT("n", "<Leader>da", [[idate +%Y-%m-%d!!bash<CR>]])

NOREMAP_SILENT(
    "n",
    "<Leader>vn",
    ":vnew | setlocal buftype=nofile | setlocal nobuflisted<CR>"
)

NOREMAP_SILENT("n", "<Leader>vs", ":vsplit<CR>")

NOREMAP_SILENT("n", "<bs>", "<C-^>")

--- <ALT+o>
NOREMAP_SILENT("i", "ø", "<C-o>o")

--- <ALT+O>
NOREMAP_SILENT("i", "Ø", "<C-o>O")

--- Substitute current word in current line
NOREMAP_SILENT("n", "<Leader>rw", ":s/<C-R><C-W>/")

--- windo diffthis
NOREMAP_SILENT("n", "<Leader>dt", "<cmd>windo diffthis<CR>")

--- copen
NOREMAP_SILENT("n", "<Leader>co", "<cmd>copen<CR>")

-- go to last tab
NOREMAP_SILENT("n", "99", ":tablast<CR>")

--- Code outline
-- NOREMAP_SILENT("n", "<leader>co", "<cmd>AerialToggle<CR>")

--- Yank non whitespace on line
NOREMAP_SILENT(
    "n",
    "Y",
    "mQ^yg_`Q" -- ^ and g_ for skipping whitespace
)

--- Yank entire file contents
NOREMAP_SILENT("n", "<leader>fy", "mQggyG`Q")

--- Run inner paragraph via shell
NOREMAP_SILENT("n", "r<c-r>", "vipyOPgv:'<,'>!bash<CR>")

--- Keep terminal open
NOREMAP_SILENT("t", "<C-x>", "<C-\\><C-n>")

--- Tab close
NOREMAP_SILENT("n", "<c-x>", "<cmd>tabclose<CR>")

--- substitute for visual mode
NOREMAP_SILENT("v", "<C-s>", ":s/")

--- no highlight
NOREMAP_SILENT("n", "--", ":noh<CR>")

--- exit out of a terminal buffer
NOREMAP_SILENT("t", "<c-e>", [[<C-\><C-n>:bd!<CR>]])
-- NOREMAP_SILENT("n", "<tab>", ":bnext<CR>")
-- NOREMAP_SILENT("n", "<s-tab>", ":bprev<CR>")

NOREMAP_SILENT("n", "<leader>d", '"_d')
NOREMAP_SILENT("v", "<leader>d", '"_d')

vim.api.nvim_set_keymap('n', 'j', 'v:count == 0 ? "gj" : "j"', { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'v:count == 0 ? "gk" : "k"', { noremap = true, expr = true, silent = true })
