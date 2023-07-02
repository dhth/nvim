vim.g.barbar_auto_setup = false -- disable auto-setup

require 'barbar'.setup {
  animation = false,
  auto_hide = false,
  tabpages = true,
  clickable = false,
  icons = {
      buffer_index = true,
      button = false,
  },
}


local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
for i=1,9 do
    map('n', i .. i, '<Cmd>BufferGoto '.. i .. '<CR>', opts)
end

map('n', '00', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<leader>xx', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
