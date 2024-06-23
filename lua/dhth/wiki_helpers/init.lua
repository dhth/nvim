local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
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
    for _, line in ipairs(selected_lines) do
        table.insert(changed_lines, '- [ ] ' .. TRIM(line))
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, true, changed_lines)
end

function M.open_urls()
    local start_line = vim.fn.getpos("'<")[2]
    local end_line = vim.fn.getpos("'>")[2]
    local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
    for _, line in ipairs(selected_lines) do
        if (vim.fn.match(line, 'https://') ~= -1)
        then
            vim.cmd("silent !open " .. line)
        end
    end
end

function M.open_current_pages_webview()
    local project_dir = vim.fn.getcwd() .. "/"
    local file_path = vim.fn.expand("%")
    local file_path_in_project_dir = string.gsub(file_path, project_dir, "")

    local config_file = ".preview-page.lua"
    local config = dofile(config_file)

    local output = file_path_in_project_dir
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
    for _, line in ipairs(selected_lines) do
        table.insert(changed_lines, '- ' .. TRIM(line))
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, true, changed_lines)
end

function M.toggle_visual_checklist()
    local start_line = vim.fn.getpos("'<")[2]
    local end_line = vim.fn.getpos("'>")[2]
    local selected_lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
    local changed_lines = {}
    for _, line in ipairs(selected_lines) do
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
    for _, line in ipairs(selected_lines) do
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

function M.reference_existing_link()
    local opts = {
        prompt_title = "~ links ~",
        previewer = false,
        sorting_strategy = "ascending",
    }
    pickers.new(opts, {
        finder = finders.new_oneshot_job({ "rg", [[^- \[\S.*\]\[\d+\]$]], vim.fn.expand('%:p') }, opts),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local link = selection.value
                local split_elems = SPLIT_STRING(link, "][")
                local link_number = SPLIT(split_elems[#split_elems], "]")[1]
                vim.cmd("normal! i[][" .. link_number .. "]F[F[")
            end)
            return true
        end,

    }):find()
end

return M
