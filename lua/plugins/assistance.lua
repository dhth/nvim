return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = false,
                keymap = {
                    accept = "<Right>",
                    dismiss = "<C-]>",
                },
            },
            nes = {
                enabled = false,
            },
        },
        keys = {
            {
                "<leader>ac",
                function()
                    require("copilot.suggestion").toggle_auto_trigger()
                end,
                desc = "Toggle Copilot Auto Trigger",
            },
        },
    },
}
