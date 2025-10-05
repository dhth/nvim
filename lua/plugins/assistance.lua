return {
    {
        "folke/sidekick.nvim",
        dependencies = {},
        opts = {},
        keys = {
            {
                "<C-p>",
                function()
                    require("sidekick.cli").toggle {
                        name = "codex",
                        focus = true,
                    }
                end,
                desc = "Sidekick Codex Toggle",
                mode = { "n", "v" },
            },
            {
                "<leader>ap",
                function()
                    require("sidekick.cli").prompt()
                end,
                desc = "Sidekick Ask Prompt",
                mode = { "n", "v" },
            },
        },
    },
}
