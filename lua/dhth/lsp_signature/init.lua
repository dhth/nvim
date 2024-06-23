require "lsp_signature".setup({
    bind = true,
    floating_window_above_cur_line=true,
    floating_window_off_y = -1,
    doc_lines = 10,
    toggle_key = "<c-x>",
    toggle_key_flip_floatwin_setting = true,
    fix_pos = false,
    hint_enable = false,
    handler_opts = {
        border = "none"   -- double, single, shadow, none
    },
}
)
