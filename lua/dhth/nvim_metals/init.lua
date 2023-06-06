local api = vim.api

-- vim.opt_global.shortmess:remove("F"):append("c")


local function map(mode, lhs, rhs)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options)
    end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>ff', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>jj', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>vv', '<cmd>vsp | lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>de', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'X', '<cmd>lua require("dhth.nvim_lspconfig.custom_hover").show_file_definition_path()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
--- using lspsaga
-- map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>rr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>')
--- using lspsaga
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<space>qf', '<cmd>lua vim.diagnostic.set_loclist()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.format({async=true})<CR>')
map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) -- all workspace diagnostics

-- map("n", "<leader>ff", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- map('n', '<leader>jj', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>')
-- map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
-- map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
-- map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
-- map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
-- map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
-- map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
-- map("n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>')
-- map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) -- all workspace diagnostics
-- map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]) -- all workspace errors
-- map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]) -- all workspace warnings
-- map("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>") -- buffer diagnostics only
-- map("n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>")
-- map("n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>")

local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"

metals_config.settings = {
    showImplicitArguments = true,
}

local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })

api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})
