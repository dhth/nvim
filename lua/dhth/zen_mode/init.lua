require("zen-mode").setup (
{
    window = {
        backdrop = 1,
        width = 120,
        height = 1,
    },
    plugins = {
        options = {
            enabled = true,
            ruler = false,
            showcmd = false,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = true },
    },
}
)
