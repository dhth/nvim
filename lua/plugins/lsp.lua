return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local nvim_lsp = require "lspconfig"

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(_, bufnr)
                local function buf_set_keymap(...)
                    vim.api.nvim_buf_set_keymap(bufnr, ...)
                end
                local function buf_set_option(...)
                    vim.api.nvim_buf_set_option(bufnr, ...)
                end

                buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

                local opts = { noremap = true, silent = true }

                buf_set_keymap(
                    "n",
                    "<leader>ff",
                    "<cmd>lua vim.lsp.buf.definition()<CR>",
                    opts
                )
                buf_set_keymap(
                    "n",
                    "df",
                    "<cmd>lua vim.lsp.buf.definition()<CR>",
                    opts
                )
                buf_set_keymap(
                    "n",
                    "<leader>jj",
                    "<cmd>tab split | lua vim.lsp.buf.definition()<CR>",
                    opts
                )
                buf_set_keymap(
                    "n",
                    "<leader>vv",
                    "<cmd>vsp | lua vim.lsp.buf.definition()<CR>",
                    opts
                )
                buf_set_keymap(
                    "n",
                    "<leader>de",
                    "<cmd>lua vim.lsp.buf.declaration()<CR>",
                    opts
                )
                buf_set_keymap(
                    "n",
                    "K",
                    "<cmd>lua vim.lsp.buf.hover()<CR>",
                    opts
                )
                buf_set_keymap(
                    "n",
                    "X",
                    '<cmd>lua require("custom.lspconfig").show_file_definition_path()<CR>',
                    opts
                )
                buf_set_keymap(
                    "n",
                    "gi",
                    "<cmd>lua vim.lsp.buf.implementation()<CR>",
                    opts
                )
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
                buf_set_keymap(
                    "n",
                    "<space>rn",
                    "<cmd>lua vim.lsp.buf.rename()<CR>",
                    opts
                )
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
                buf_set_keymap(
                    "n",
                    "[d",
                    "<cmd>lua vim.diagnostic.goto_prev()<CR>",
                    opts
                ) -- turn float=true if not using lsp_lines
                buf_set_keymap(
                    "n",
                    "]d",
                    "<cmd>lua vim.diagnostic.goto_next()<CR>",
                    opts
                ) -- turn float=true if not using lsp_lines
                buf_set_keymap(
                    "n",
                    "f<c-f>",
                    '<cmd>lua require("custom.helpers.code.general").format_using_lsp()<CR>',
                    opts
                )
            end

            vim.diagnostic.config {
                virtual_text = false,
            }

            -- PYTHON
            nvim_lsp.pyright.setup {
                on_attach = on_attach,
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

            -- SCALA
            require("lspconfig").metals.setup {
                on_attach = on_attach,
            }

            -- C
            nvim_lsp.ccls.setup {
                on_attach = on_attach,
            }

            -- LUA
            nvim_lsp.lua_ls.setup {
                on_attach = on_attach,
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

            -- RUST
            nvim_lsp.rust_analyzer.setup {
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enable = true,
                        },
                    },
                },
            }

            -- GO
            nvim_lsp.gopls.setup {
                on_attach = on_attach,
                settings = {
                    gopls = {
                        gofumpt = true,
                    },
                },
            }

            -- TERRAFORM
            nvim_lsp.terraformls.setup {
                on_attach = on_attach,
            }

            -- ELM
            nvim_lsp.elmls.setup {
                on_attach = on_attach,
            }

            NOREMAP_SILENT("n", "<leader>hh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end)
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
