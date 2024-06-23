require "dhth.general"
require "dhth.globals"
require "dhth.helpers"
require "dhth.settings"
require "dhth.colors"
require "dhth.cmds"

-- tabs and buffers
require "dhth.lualine"
require "dhth.barbar"

-- sessions
-- require "dhth.sessions"

-- treesitter
require "dhth.treesitter"
require "dhth.nvim_treesitter_textobjects"
require "dhth.nvim_treesitter_context"
require "dhth.mini_indentscope"
require("aerial").setup()
-- require('refactoring').setup()
-- require "dhth.block"

-- autocomplete/lsp
require "dhth.nvim_cmp"
require "dhth.vim_vsnip"
require "dhth.luadev"
require "dhth.nvim_lspconfig"
require "dhth.lsp_signature"
-- require "dhth.lspsaga"
require "dhth.nvim_metals"
-- require "dhth.lsp_lines"
-- require "dhth.symbols_outline"
require "dhth.nvim_dap"

-- search
require "dhth.telescope.setup"
require "dhth.trouble"
require "dhth.nvim_autopairs"
require "dhth.harpoon"

-- git
require "dhth.gitsigns"
require "dhth.diffview"
-- require "octo".setup({
--     suppress_missing_scope = {
--         projects_v2 = true,
--     }
-- })

-- movement
-- require "dhth.flash"
require('leap').create_default_mappings()

-- other
require "dhth.vim_highlighter"
-- require('Comment').setup()
-- require "dhth.marks"
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
require("CopilotChat").setup {}
