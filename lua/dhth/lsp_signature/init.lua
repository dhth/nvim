require "lsp_signature".setup({
    floating_window_above_cur_line=true,
    doc_lines = 5,
    fix_pos = true,
    hint_enable = false,
    handler_opts = {
        border = "none"   -- double, single, shadow, none
    },
}
)
