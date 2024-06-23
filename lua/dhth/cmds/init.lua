vim.api.nvim_create_user_command(
    'Hd',
    function(opts)
        vim.cmd[[DiffviewOpen HEAD~1..HEAD]]
    end,
    {}
)
