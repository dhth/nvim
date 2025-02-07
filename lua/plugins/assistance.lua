return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            require("CopilotChat").setup {
                auto_follow_cursor = false,
            }

            --- copilot toggle
            NOREMAP_SILENT("n", "<c-p>", ":CopilotChatToggle<CR>")

            NOREMAP_SILENT("n", "<c-q>", function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                end
            end)
        end,
    },
}
