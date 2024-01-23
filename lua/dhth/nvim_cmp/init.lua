local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup({
    -- completion = {
    --   autocomplete = false
    -- },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping =
    -- {
    --     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    --     ['<C-u>'] = cmp.mapping.scroll_docs(4),
    --     ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    --     ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    --     ['<C-Space>'] = cmp.mapping.complete(),
    --     ['<C-e>'] = cmp.mapping.close(),
    --     ['<CR>'] = cmp.mapping.confirm({
    --         behavior = cmp.ConfirmBehavior.Insert,
    --         select = true
    --     }
    --     ),
    -- },
        cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-u>'] = cmp.mapping.scroll_docs(4),
            ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-r>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Insert }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
    sources = cmp.config.sources({
        --- get suggestions from all open buffers
        { name = 'nvim_lsp' },
        -- { name = 'buffer', option = {
        --     get_bufnrs = function()
        --         return vim.api.nvim_list_bufs()
        --     end
        -- } },
        { name = 'vsnip' },
        -- { name = 'orgmode' },
        { name = 'path' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }
    ),
    -- more on cmp customization here:
    -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            -- maxwidth = 50,
            menu = {
                nvim_lsp = "[LSP]",
                vsnip = "[SNIPPET]",
                path = "[path]",
                buffer = "[BUFFER]",
            },
        })
    },
})

cmp.setup.filetype('markdown', {
    sources = cmp.config.sources({
        {
            name = 'buffer',
            -- default is just the current buffer
            -- option = {
            --     get_bufnrs = function()
            --         return vim.api.nvim_list_bufs()
            --     end
            -- }
        },
        { name = 'vsnip' },
        { name = 'path' },
    })
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'vsnip' },
        { name = 'path' },
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}
