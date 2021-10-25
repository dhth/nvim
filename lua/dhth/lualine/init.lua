require('lualine').setup({
    options = {
        theme = 'gruvbox',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', {'diagnostics', sources={'nvim_lsp'}}},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    tabline = {
        lualine_a = {
            {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1,
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    fzf = 'FZF',
                }
            }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'}
    }
}
)
