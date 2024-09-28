require "lsp_signature".setup({
    bind = true,
    doc_lines = 20,
    toggle_key = "<c-x>",
    -- toggle_key_flip_floatwin_setting = true,
    fix_pos = false,
    hint_enable = false,
    handler_opts = {
        border = "none"   -- double, single, shadow, none
    },
    zindex = 40,
    padding = ' ',
}
)
