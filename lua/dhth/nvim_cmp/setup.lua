local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
          expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
              end,
            },
            mapping = {
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-u>'] = cmp.mapping.scroll_docs(4),
                ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                }
                ),
            },
            sources = cmp.config.sources({
                --- get suggestions from all open buffers
                { name = 'nvim_lsp' },
                { name = 'buffer', option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                } },
                { name = 'vsnip' },
                { name = 'orgmode' },
                { name = 'path' },
                -- { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }
            ),
            formatting = {
                format = lspkind.cmp_format({
                    with_text = false,
                    maxwidth = 50,
                    menu = {
                        buffer = " ﬘ ",
                        nvim_lsp = "[LSP]",
                        vsnip = "[SNIPPET]",
                        path = "[path]"
                    },
                })
            },
            experimental = {
                native_menu = false,
            }
        })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
