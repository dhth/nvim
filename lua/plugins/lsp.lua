--- @param client vim.lsp.Client
--- @param bufnr integer
local function lsp_on_attach(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true }

    buf_set_keymap("n", "F", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "df", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap(
        "n",
        "T",
        "<cmd>tab split | lua vim.lsp.buf.definition()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "L",
        "<cmd>vsp | lua vim.lsp.buf.definition()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<leader>de",
        "<cmd>lua vim.lsp.buf.declaration()<CR>",
        opts
    )
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap(
        "n",
        "X",
        '<cmd>lua require("custom.lspconfig").show_file_definition_path()<CR>',
        opts
    )
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap(
        "n",
        "<space>wa",
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<space>wr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<space>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<space>D",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        opts
    )
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    --- using lspsaga
    buf_set_keymap(
        "n",
        "<space>ca",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<space>e",
        "<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>",
        opts
    )
    --- using lspsaga
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- turn float=true if not using lsp_lines
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- turn float=true if not using lsp_lines
    buf_set_keymap(
        "n",
        "f<c-f>",
        '<cmd>lua require("custom.helpers.code.general").format_using_lsp()<CR>',
        opts
    )

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                if vim.api.nvim_buf_line_count(bufnr) < 500 then
                    vim.lsp.buf.format { async = false }
                end
            end,
        })
    end
end

-- to not use LSP
-- nvim --cmd "let g:lsp=v:false"
if vim.g.lsp == false then
    return {}
end

return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local nvim_lsp = require "lspconfig"

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer

            vim.diagnostic.config {
                virtual_text = false,
            }

            -- C
            nvim_lsp.ccls.setup {
                on_attach = lsp_on_attach,
            }

            -- ELM
            nvim_lsp.elmls.setup {
                on_attach = lsp_on_attach,
            }

            -- GO
            nvim_lsp.gopls.setup {
                on_attach = lsp_on_attach,
                settings = {
                    gopls = {
                        gofumpt = true,
                    },
                },
            }

            -- GLEAM
            nvim_lsp.gleam.setup {
                on_attach = lsp_on_attach,
            }

            -- HASKELL
            vim.lsp.config("hls", {
                filetypes = { "haskell", "lhaskell", "cabal" },
            })
            nvim_lsp.hls.setup {
                on_attach = lsp_on_attach,
            }

            -- LUA
            nvim_lsp.lua_ls.setup {
                on_attach = lsp_on_attach,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        diagnostics = {
                            globals = {
                                "hs", -- for hammerspoon config
                                "vim",
                            },
                        },
                    },
                },
            }

            -- PYTHON
            -- nvim_lsp.ty.setup {
            --     on_attach = lsp_on_attach,
            -- }
            -- vim.lsp.enable('ty')

            nvim_lsp.pyright.setup {
                on_attach = lsp_on_attach,
                flags = {
                    debounce_text_changes = 150,
                },
                settings = {
                    python = {
                        analysis = {
                            diagnosticSeverityOverrides = {
                                reportUnusedVariable = false,
                            },
                        },
                    },
                },
            }

            -- RUST
            nvim_lsp.rust_analyzer.setup {
                on_attach = lsp_on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enable = true,
                        },
                    },
                },
            }

            -- SCALA
            -- nvim_lsp.metals.setup {
            --     on_attach = lsp_on_attach,
            -- }

            -- TERRAFORM
            nvim_lsp.terraformls.setup {
                on_attach = lsp_on_attach,
            }

            -- TYPESCRIPT
            nvim_lsp.ts_ls.setup {
                on_attach = lsp_on_attach,
            }

            -- ZIG
            -- nvim_lsp.zls.setup {
            --     on_attach = lsp_on_attach,
            -- }

            NOREMAP_SILENT("n", "<leader>hh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end)
        end,
    },
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "j-hui/fidget.nvim",
                opts = {},
            },
        },
        ft = { "scala", "sbt" },
        opts = function()
            local metals_config = require("metals").bare_config()

            -- metals_config.settings = {
            --     showImplicitArguments = true,
            -- }

            -- "off" will enable LSP progress notifications by Metals; handle them via a receiver like fidget.nvim
            -- "on" will enable the custom Metals status extension and you *have* to have
            -- a have settings to capture this in your statusline or else you'll not see
            -- any messages from metals
            metals_config.init_options.statusBarProvider = "off"

            -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
            metals_config.capabilities =
                require("cmp_nvim_lsp").default_capabilities()

            metals_config.on_attach = function(client, bufnr)
                lsp_on_attach(client, bufnr)
                local function buf_set_keymap(...)
                    vim.api.nvim_buf_set_keymap(bufnr, ...)
                end
                local opts = { noremap = true, silent = true }

                -- all workspace errors
                buf_set_keymap(
                    "n",
                    "<leader>ae",
                    [[<cmd>lua vim.diagnostic.setqflist({ severity = "E" })<CR>]],
                    opts
                )

                -- all workspace warnings
                buf_set_keymap(
                    "n",
                    "<leader>aw",
                    [[<cmd>lua vim.diagnostic.setqflist({ severity = "W" })<CR>]],
                    opts
                )
            end

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group =
                vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("fidget").setup {}
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            bind = true,
            doc_lines = 20,
            toggle_key = "<c-x>",
            fix_pos = false,
            hint_enable = false,
            handler_opts = {
                border = "none", -- double, single, shadow, none
            },
            zindex = 40,
            padding = " ",
        },
    },
}
