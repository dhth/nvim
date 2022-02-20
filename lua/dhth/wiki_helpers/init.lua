local M = {}

function M.toggle_line_checklist()
    local start_line = vim.fn.getpos(".")[2]
    local current_line = vim.fn.getline(".")
    local changed_lines = {}
    if (vim.fn.match(current_line, '- \\[ \\]') ~= -1)
        then
        table.insert(changed_lines, vim.fn.substitute(current_line, '- \\[ \\]', '- \\[x\\]', ""))
    elseif (vim.fn.match(current_line, '- \\[x\\]') ~= -1)
        then
        table.insert(changed_lines, vim.fn.substitute(current_line, '- \\[x\\]', '- \\[ \\]', ""))
    else
        table.insert(changed_lines, current_line)
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, start_line, true, changed_lines)
end

function M.toggle_visual_checklist()
    local start_line = vim.fn.getpos("'<")[2]
    local end_line = vim.fn.getpos("'>")[2]
    local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
    local changed_lines = {}
    for _,line in ipairs(selected_lines) do
        if (vim.fn.match(line, '- \\[ \\]') ~= -1)
            then
            table.insert(changed_lines, vim.fn.substitute(line, '- \\[ \\]', '- \\[x\\]', ""))
        elseif (vim.fn.match(line, '- \\[x\\]') ~= -1)
            then
            table.insert(changed_lines, vim.fn.substitute(line, '- \\[x\\]', '- \\[ \\]', ""))
        else
            table.insert(changed_lines, line)
        end
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, true, changed_lines)
end

function M.quotify_visual()
    local start_line = vim.fn.getpos("'<")[2]
    local end_line = vim.fn.getpos("'>")[2]
    local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
    local changed_lines = {}
    for _,line in ipairs(selected_lines) do
        table.insert(changed_lines, "> " .. line)
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, true, changed_lines)
end

return M