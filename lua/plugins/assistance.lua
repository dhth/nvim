return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
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
        end,
    },
}
