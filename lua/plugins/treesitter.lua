local managed_parsers = {
    "css",
    "gleam",
    "go",
    "gotmpl",
    "helm",
    "hocon",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "scala",
    "terraform",
    "toml",
    "typescript",
    "yaml",
}

local disabled_filetypes = {
    fugitive = true,
    html = true,
    javascript = true,
    markdown = true,
    vimdoc = true,
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        config = function()
            vim.api.nvim_create_user_command("TSInstallManaged", function()
                require("nvim-treesitter").install(
                    managed_parsers,
                    { summary = true }
                )
            end, {})

            vim.api.nvim_create_user_command("TSUpdateManaged", function()
                require("nvim-treesitter").update(
                    managed_parsers,
                    { summary = true }
                )
            end, {})

            vim.api.nvim_create_user_command("TSListInstalled", function()
                local installed = require("nvim-treesitter").get_installed()
                vim.print(installed)
            end, {})

            local group = vim.api.nvim_create_augroup(
                "treesitter_highlighting",
                { clear = true }
            )

            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(args)
                    local filetype = vim.bo[args.buf].filetype

                    if disabled_filetypes[filetype] then
                        return
                    end

                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    lookahead = true,
                },
                move = {
                    set_jumps = true,
                },
            }

            local select = require "nvim-treesitter-textobjects.select"
            local move = require "nvim-treesitter-textobjects.move"
            local swap = require "nvim-treesitter-textobjects.swap"

            vim.keymap.set({ "x", "o" }, "af", function()
                select.select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                select.select_textobject("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@class.inner", "textobjects")
            end)

            vim.keymap.set({ "n", "x", "o" }, "]v", function()
                move.goto_next_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]w", function()
                move.goto_next_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "][", function()
                move.goto_next_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                move.goto_next_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[v", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[w", function()
                move.goto_previous_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[]", function()
                move.goto_previous_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                move.goto_previous_end("@class.outer", "textobjects")
            end)

            vim.keymap.set("n", "<leader>s8", function()
                swap.swap_next "@parameter.inner"
            end)
            vim.keymap.set("n", "<leader>s9", function()
                swap.swap_next "@function.outer"
            end)
            vim.keymap.set("n", "<leader>s7", function()
                swap.swap_previous "@parameter.inner"
            end)
            vim.keymap.set("n", "<leader>s6", function()
                swap.swap_previous "@function.outer"
            end)
        end,
    },
}
