return {
    {
        "ggandor/leap.nvim",
        event = "InsertEnter",
        config = function()
            require("leap").create_default_mappings()
        end,
    },
}
