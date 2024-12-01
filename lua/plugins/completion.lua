return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "onsails/lspkind-nvim",
            {
                "uga-rosa/cmp-dictionary",
                config = function()
                    require("cmp_dictionary").setup {
                        paths = { "/usr/share/dict/words" },
                        exact_length = 4,
                    }
                end,
            },
        },
        config = function()
            local cmp = require "cmp"
            local lspkind = require "lspkind"

            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<Tab>"] = cmp.mapping.select_next_item {
                        behavior = cmp.SelectBehavior.Insert,
                    },
                    ["<S-Tab>"] = cmp.mapping.select_prev_item {
                        behavior = cmp.SelectBehavior.Insert,
                    },
                    ["<Down>"] = cmp.mapping.select_next_item {
                        behavior = cmp.SelectBehavior.Insert,
                    },
                    ["<Up>"] = cmp.mapping.select_prev_item {
                        behavior = cmp.SelectBehavior.Insert,
                    },
                    ["<C-r>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.SelectBehavior.Insert,
                    }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                },
                sources = cmp.config.sources {
                    --- get suggestions from all open buffers
                    { name = "nvim_lsp" },
                    -- { name = 'buffer', option = {
                    --     get_bufnrs = function()
                    --         return vim.api.nvim_list_bufs()
                    --     end
                    -- } },
                    { name = "vsnip" },
                    -- { name = 'orgmode' },
                    { name = "path" },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                },
                -- more on cmp customization here:
                -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
                formatting = {
                    format = lspkind.cmp_format {
                        mode = "symbol_text",
                        -- maxwidth = 50,
                        menu = {
                            nvim_lsp = "[LSP]",
                            vsnip = "[SNIPPET]",
                            path = "[path]",
                            buffer = "[BUFFER]",
                        },
                    },
                },
            }

            cmp.setup.filetype("markdown", {
                sources = cmp.config.sources {
                    { name = "dictionary", keyword_length = 4 },
                    { name = "vsnip" },
                    { name = "path" },
                },
            })
            cmp.setup.filetype("copilot-chat", {
                sources = cmp.config.sources {
                    { name = "dictionary", keyword_length = 4 },
                },
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources {
                    { name = "dictionary", keyword_length = 4 },
                    { name = "vsnip" },
                    { name = "path" },
                },
            })

            cmp.setup.filetype("terraform", {
                completion = {
                    autocomplete = { cmp.TriggerEvent.TextChanged },
                },
            })

            -- https://github.com/hrsh7th/nvim-cmp/issues/261#issuecomment-1860408641
            local function toggle_autocomplete()
                local current_setting = cmp.get_config().completion.autocomplete
                if current_setting and #current_setting > 0 then
                    cmp.setup { completion = { autocomplete = false } }
                    print "autocomplete disabled"
                else
                    cmp.setup {
                        completion = {
                            autocomplete = { cmp.TriggerEvent.TextChanged },
                        },
                    }
                    print "autocomplete enabled"
                end
            end

            vim.api.nvim_create_user_command(
                "CmpToggle",
                toggle_autocomplete,
                {}
            )
        end,

        NOREMAP_SILENT("n", "<leader>ac", ":CmpToggle<CR>"),
    },
    {
        "hrsh7th/vim-vsnip",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-vsnip",
        },
        config = function()
            vim.cmd [[imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']]
            vim.cmd [[imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']]
            vim.cmd [[let g:vsnip_snippet_dir = expand('~/.config/nvim/snippets')]]
            local opts = { noremap = true, silent = true }

            --- open snippets
            REMAP("n", "<Leader>sn", ":VsnipOpen<CR>", opts)
        end,
    },
}
