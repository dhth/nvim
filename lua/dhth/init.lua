require "dhth.general"
require "dhth.globals"
require "dhth.helpers"
require "dhth.settings"

-- treesitter
require "dhth.treesitter"
require "dhth.nvim_treesitter_textobjects"
require "dhth.nvim_treesitter_context"

-- autocomplete/lsp
require "dhth.nvim_cmp.setup"
require "dhth.vim_vsnip"
require "dhth.nvim_lspconfig"
require "dhth.lsp_signature"
require "dhth.lspsaga"
require "dhth.nvim_metals"
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
-- require "hop".setup()

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

-- require("lsp_lines").setup()
-- vim.diagnostic.config({
--   virtual_text = false,
-- })

require 'marks'.setup {
  bookmark_0 = {
    sign = "0",
    virt_text = "0",
    annotate = false,
  },
  bookmark_1 = {
    sign = "1",
    virt_text = "1",
    annotate = false,
  },
    mappings = {
        next = "]v",
        previous = "[v",
        set_bookmark0 = "m0",
    }
}

require('leap').set_default_keymaps()


-- require('neorg').setup {
--     load = {
--         ["core.defaults"] = {}
--     }
-- }
