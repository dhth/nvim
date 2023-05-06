require "dhth.nvim_lspconfig.custom_hover"
local util = require 'lspconfig/util'

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>jj', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>vv', '<cmd>vsp | lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>de', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --- using lspsaga
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'X', '<cmd>lua require("dhth.nvim_lspconfig.custom_hover").show_file_definition_path()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'M', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --- using lspsaga
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  --- using lspsaga
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>qf', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- PYTHON
nvim_lsp.pyright.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = function(fname)
        local root_files = {
            'pyrightconfig.json',
        }
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
    end,
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = false,
                }
            }
        }
    }
}

-- LUA

-- local system_name
-- if vim.fn.has("mac") == 1 then
--   system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
--   system_name = "Linux"
-- elseif vim.fn.has('win32') == 1 then
--   system_name = "Windows"
-- else
--   print("Unsupported system for sumneko")
-- end

local user = vim.fn.expand('$USER')
local sumneko_root_path = '/Users/' .. user ..'/soft/lua-language-server'
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/".."/lua-language-server"

-- require("neodev").setup({
--   -- add any options here, or leave empty to use the default settings
-- })

-- local luadev = require("neodev").setup({
--   -- add any options here, or leave empty to use the default settings
--   lspconfig = {
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--     on_attach = on_attach,
--   },
-- })

-- nvim_lsp.sumneko_lua.setup(luadev)


-- -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
-- local sumneko_root_path = '/Users/dht93/Soft/lua-language-server'
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

-- nvim_lsp.sumneko_lua.setup {
--     on_attach = on_attach,
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--                 -- Setup your lua path
--                 path = runtime_path,
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = {'vim'},
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = {
--                     vim.api.nvim_get_runtime_file("", true),
--                     -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--                     -- [vim.fn.expand("/Users/dht93/Soft/neovim/src/nvim/lua")] = true,
--                 }
--             },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- }


-- SCALA

-- using nvim-metals for this
-- require'lspconfig'.metals.setup{
--     on_attach = on_attach,
-- }

-- vim.lsp.set_log_level("debug")

-- TYPESCRIPT
-- nvim_lsp.tsserver.setup{}

-- PURESCRIPT
nvim_lsp.purescriptls.setup{}

-- C
require'lspconfig'.ccls.setup{}
