require "dhth.globals"
require "dhth.helpers"

-- treesitter
require "dhth.treesitter"
require "dhth.nvim_treesitter_textobjects"
require "dhth.nvim_treesitter_context"

-- autocomplete/lsp
require "dhth.nvim_cmp.setup"
require "dhth.vim_vsnip"
require "dhth.nvim_lspconfig"
require "dhth.lsp_signature"
require "dhth.symbols_outline"

-- search
require "dhth.telescope.setup"
require "dhth.trouble"
require "dhth.nvim_autopairs"
-- require "dhth.harpoon"

-- git
require "dhth.gitsigns"
require "dhth.diffview"
require "octo".setup()

-- movement
require "hop".setup()

-- other
require "dhth.vim_highlighter"
require('Comment').setup()
require "dhth.nvim_notify"
require "dhth.zen_mode"


require "dhth.wiki_helpers"
require "dhth.mappings"
require "dhth.test_helpers.mappings"
