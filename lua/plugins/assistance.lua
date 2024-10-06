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
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "avante ask" },
        },
        opts = {
            provider = "copilot",
            hints = { enabled = false },
            windows = {
                width = 50,
                sidebar_header = {
                    rounded = false,
                },
            },
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "zbirenbaum/copilot.lua",
        },
    },
}
