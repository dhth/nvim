return {
    {
        "saghen/blink.cmp",
        dependencies = {},

        version = "1.*",
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "select_and_accept", "fallback" },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = { documentation = { auto_show = false } },

            sources = {
                default = { "lsp", "path" },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
