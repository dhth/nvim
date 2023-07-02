require "dhth.general"
require "dhth.globals"
require "dhth.helpers"
require "dhth.settings"
require "dhth.colors"

-- tabs and buffers
require "dhth.lualine"
require "dhth.barbar"

-- sessions
require "dhth.sessions"

-- treesitter
require "dhth.treesitter"
require "dhth.nvim_treesitter_textobjects"
require "dhth.nvim_treesitter_context"
-- require "dhth.block"

-- autocomplete/lsp
require "dhth.nvim_cmp.setup"
require "dhth.vim_vsnip"
require "dhth.nvim_lspconfig"
require "dhth.lsp_signature"
require "dhth.lspsaga"
require "dhth.nvim_metals"
require "dhth.lsp_lines"
-- require "dhth.symbols_outline"

-- search
require "dhth.telescope.setup"
require "dhth.trouble"
require "dhth.nvim_autopairs"
require "dhth.harpoon"

-- git
require "dhth.gitsigns"
require "dhth.diffview"
-- require "octo".setup()

-- movement
require "dhth.hop"
-- require('leap').set_default_keymaps()

-- other
require "dhth.vim_highlighter"
require('Comment').setup()
-- require "dhth.nvim_notify"
-- require "dhth.zen_mode"

require "dhth.wiki_helpers"
require "dhth.code_helpers"
require "dhth.git_helpers"
require "dhth.mappings"
require "dhth.test_helpers.mappings"

-- require('neorg').setup {
--     load = {
--         ["core.defaults"] = {}
--     }
-- }
