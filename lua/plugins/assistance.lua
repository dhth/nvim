return {
    -- {
    --     "CopilotC-Nvim/CopilotChat.nvim",
    --     branch = "main",
    --     dependencies = {
    --         { "zbirenbaum/copilot.lua" },
    --         { "nvim-lua/plenary.nvim" },
    --     },
    --     config = function()
    --         require("CopilotChat").setup {
    --             auto_follow_cursor = false,
    --         }
    --
    --         --- copilot toggle
    --         NOREMAP_SILENT("n", "<c-p>", ":CopilotChatToggle<CR>")
    --
    --         NOREMAP_SILENT("n", "<c-q>", function()
    --             local input = vim.fn.input "Quick Chat: "
    --             if input ~= "" then
    --                 require("CopilotChat").ask(
    --                     input,
    --                     { selection = require("CopilotChat.select").buffer }
    --                 )
    --             end
    --         end)
    --     end,
    -- },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            opts = {
                log_level = "INFO",
            },
        },
        config = function()
            require("codecompanion").setup {
                strategies = {
                    chat = {
                        name = "copilot",
                        model = "claude-sonnet-4",
                    },
                    inline = {
                        name = "copilot",
                        model = "claude-sonnet-4",
                    },
                },
            }

            --- toggle
            NOREMAP_SILENT("n", "<c-p>", ":CodeCompanionChat Toggle<CR>")
            --- run CodeCompanion on visual selection
            NOREMAP_SILENT("v", "<c-p>", ":CodeCompanionChat ")
        end,
    },
}
