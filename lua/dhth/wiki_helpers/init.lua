local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

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

function M.add_visual_checklist()
    local start_line = vim.fn.getpos("'<")[2]
    local end_line = vim.fn.getpos("'>")[2]
    local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
    local changed_lines = {}
    for _,line in ipairs(selected_lines) do
        table.insert(changed_lines, '- [ ] ' .. line)
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, true, changed_lines)
end

function M.open_current_pages_webview()
    local bufnr = vim.fn.bufnr("%")
    local file_path = vim.fn.bufname(bufnr)

    local config_file = ".preview-page.lua"
    local config = dofile(config_file)

    local output = file_path
    for _, command in ipairs(config.commands) do
        output = command(output)
    end

    vim.cmd("silent !" .. output)

end

function M.add_visual_list()
    local start_line = vim.fn.getpos("'<")[2]
    local end_line = vim.fn.getpos("'>")[2]
    local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
    local changed_lines = {}
    for _,line in ipairs(selected_lines) do
        table.insert(changed_lines, '- ' .. line)
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, true, changed_lines)
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

function M.search_for_tags()
    local tag = '#currently-active'
    local opts = {
        search = tag,
        prompt_title = "~ " .. tag .. " ~",
        previewer = false,
    }

    require("telescope.builtin").grep_string(opts)
end

return M
