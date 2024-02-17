local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local git_helpers = require "dhth.git_helpers"
local theme = require('telescope.themes').get_ivy

local M = {}


function M.format_file()
    local file_type = vim.bo.filetype
    if file_type == "python" then
        vim.api.nvim_exec2(':silent ! ruff format %', { output = false })
    else
        vim.lsp.buf.format({ async = true })
    end
end

function M.scala_run_main_file(switch_to_pane)
    switch_to_pane = switch_to_pane or false

    local mainFile = string.gsub((string.gsub(vim.fn.expand('%:r'), "src/main/scala/", "")), "/", ".")
    vim.cmd('silent VimuxRunCommand("runMain ' .. mainFile .. '")')
    if switch_to_pane then
        vim.cmd('silent !tmux select-pane -t .+1 && tmux resize-pane -Z')
    end
end

function M.scala_cli_run(switch_to_pane)
    switch_to_pane = switch_to_pane or false

    local filePath = vim.fn.expand('%')

    local command
    if ENDSWITH(filePath, '.test.scala') then
        command = "scala-cli test"
    else
        command = "scala-cli run"
    end

    vim.cmd('silent VimuxRunCommand("' .. command .. ' ' .. filePath .. '")')

    if switch_to_pane then
        vim.cmd('silent !tmux select-pane -t .+1 && tmux resize-pane -Z')
    end
end

function M.scala_run(switch_to_pane)
    local is_a_scala_cli_project = DOES_FILE_EXIST(".bsp/scala-cli.json")

    if is_a_scala_cli_project then
        M.scala_cli_run(switch_to_pane)
    else
        M.scala_run_main_file(switch_to_pane)
    end
end

local function create_telescope_search(opts)
    local file_type = vim.bo.filetype
    local config
    if file_type == "scala" then
        config = {
            { "run" },
            { "docs/makeSite" },
            { "compile" },
            { "test" },
            { "compile;test" },
            { "test:compile" },
            { "reload;fbrdCompliance" },
            { "reload;fbrdCompliance;compile" },
            { "reload;fbrdCompliance;compile;test" },
            { "fbrdCompliance;compile;test" },
            { "reload" },
            { "testQuick" },
            { "fbrdCompliance" },
            { "run" },
            { "clean" },
            { "docs/previewSite" },
        }
    else
        print("nothing configured for filetype, showing git helpers")
        return git_helpers.git_commands()
    end

    pickers.new(opts, {
        prompt_title = "~ " .. file_type .. " ~",
        finder = finders.new_table {
            results = config,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry[1],
                    ordinal = entry[1],
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()

                if file_type == "scala" then
                    if string.match(selection.value[1], "run") then
                        M.scala_run(true)
                    else
                        vim.cmd('silent VimuxRunCommand("' .. selection.value[1] .. '")')
                        vim.cmd('silent !tmux select-pane -t .+1 && tmux resize-pane -Z')
                    end
                elseif file_type == "fugitive" then
                    vim.cmd(selection.value[2])
                end
            end)
            actions.select_tab:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()

                if file_type == "scala" then
                    if string.match(selection.value[1], "run") then
                        M.scala_run()
                    else
                        vim.cmd('silent VimuxRunCommand("' .. selection.value[1] .. '")')
                    end
                end
                print("sent: " .. selection.value[1] .. " ⚡️")
            end)
            actions.select_vertical:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()

                if file_type == "scala" then
                    if string.match(selection.value[1], "run") then
                        M.scala_run(true)
                    else
                        vim.cmd('silent VimuxRunCommand("' .. selection.value[1] .. '")')
                        vim.cmd('silent !tmux resize-pane -Z')
                    end
                end
            end)
            return true
        end,

    }):find()
end



function M.show_commands()
    local opts = theme({
        results_title = false,
        layout_config = {
            height = .6,
        }
    })
    create_telescope_search(opts)
end

function M.add_todo_comment()
    local opts = {
        layout_config = {
            height = .6,
            width = .4,
        }
    }
    local config = {
        { "ques",  "QUES" },
        { "fixit", "FIXIT" },
    }

    pickers.new(opts, {
        prompt_title = "~ todo ~",
        results_title = "type",
        finder = finders.new_table {
            results = config,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry[1],
                    ordinal = entry[1],
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.api.nvim_command("normal O" .. selection.value[2] .. ":gccj")
            end)
            return true
        end,

    }):find()
end

function M.reload_module()
    local file_type = vim.bo.filetype

    if file_type ~= "lua" then
        print("reload module only works from a lua file")
        return
    end

    local file_path = vim.fn.expand('%:p')
    local module_name_till_end = SPLIT_STRING(file_path, "lua/dhth/")[2]

    local module_name = SPLIT_STRING(module_name_till_end, "/")[1]

    vim.cmd("lua R(\"dhth." .. module_name .. "\")")
    print("reloaded dhth." .. module_name .. " ⚡️")
end

function M.reload_selected_module()
    local packages = vim.fn.system(
        [[cat ~/.config/nvim/lua/dhth/init.lua | grep "^require \"" | awk -F  "\"" '// {print $2}' | awk -F  "dhth." '// {print $2}']])
    local packages_array = vim.split(packages, '\n')
    table.remove(packages_array) -- remove the last entry which is a empty line
    table.insert(packages_array, "dhth")

    pickers.new(opts, {
        prompt_title = "~ modules ~",
        results_title = "module",
        finder = finders.new_table {
            results = packages_array,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry,
                    ordinal = entry,
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd("lua R(\"dhth." .. selection.value .. "\")")
                print("reloaded dhth." .. selection.value .. " ⚡️")
            end)
            return true
        end,

    }):find()
end

function M.run_line_as_command()
    local line_number = vim.api.nvim_win_get_cursor(0)[1]

    local line_contents = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]

    vim.cmd("silent !" .. line_contents)
end

function M.highlight_range(bufnr, start_line, end_line, highlight_duration_ms)
    local ns_id = vim.api.nvim_create_namespace('flash_highlight')
    local hl_group = 'FlashRangeHighlight'

    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    for line = start_line, end_line do
        vim.api.nvim_buf_add_highlight(bufnr, ns_id, hl_group, line - 1, 0, -1)
    end

    vim.defer_fn(function()
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    end, highlight_duration_ms)
end

-- This function searches for a code block (most likely in a markdown file),
-- and formats its using an external formatting tool (eg. jq). It then
-- highlights the newly formatted code block for a short duration (using
-- M.highlight_range).
-- Highlight defined here: ../../../general/highlights.vim
function M.format_code_block()
    local filetype = vim.bo.filetype
    local current_line = vim.fn.line('.')
    local format_prg

    local start_line
    local end_line
    local code_block_type

    if filetype ~= 'markdown' then
        print("filetype not supported")
        return
    end

    for i = current_line, vim.fn.line('^'), -1 do
        if vim.fn.getline(i):match('^```') then
            start_line = i
            code_block_type = SPLIT_STRING(vim.fn.getline(i), "```")[2]
            break
        end
    end

    for i = current_line, vim.fn.line('$') do
        if vim.fn.getline(i):match('^```$') then
            end_line = i
            break
        end
    end

    if (start_line ~= nil) and (end_line ~= nil) then
        if code_block_type == "json" then
            format_prg = "jq"
        elseif code_block_type == "python" then
            format_prg = "black - --quiet"
        elseif code_block_type == "scala" then
            format_prg = "scalafmt --config .scalafmt.conf  --stdin --stdout --quiet"
        else
            print("Code block not supported")
            return
        end
        local range_string = string.format("%d,%d", start_line + 1, end_line - 1)
        vim.api.nvim_exec(':' .. range_string .. '!' .. format_prg, false)
    else
        print("Couldn't find a code block")
    end

    -- after formatting
    -- SLEEP(.2, function()
    local start_line_after_format = vim.fn.line('.')
    local end_line_after_format

    for i = start_line_after_format, vim.fn.line('$') do
        if vim.fn.getline(i):match('^```$') then
            end_line_after_format = i
            break
        end
    end
    if (end_line_after_format ~= nil) then
        M.highlight_range(CURRENT_BUFFER_NUMBER(), start_line_after_format, end_line_after_format - 1, 1000)
    end
    -- end)
end

function M.add_link_to_md()
    local clipboard_contents = vim.api.nvim_exec("echo getreg('*')", true)

    if string.find(clipboard_contents, "\n") then
        print("Clipboard contains multiple lines")
        return
    end

    if not string.match(clipboard_contents, "^http.*") then
        print("Clipboard doesn't contain a url")
        return
    end

    local url_to_add = clipboard_contents

    local current_bufnr = vim.fn.bufnr('%')

    local line_count = vim.fn.line('$')

    local last_line = vim.fn.getline(line_count)

    local pattern = "^%[(%d+)%]: http.*$"

    local lines_to_add
    local new_url_number

    if string.match(last_line, pattern) then
        local captured_digit = string.match(last_line, pattern)
        new_url_number = tonumber(captured_digit) + 1
        lines_to_add = { "[" .. new_url_number .. "]: " .. url_to_add }
    else
        new_url_number = 1
        lines_to_add = { "", "[" .. new_url_number .. "]: " .. url_to_add }
    end


    if lines_to_add then
        local lines = vim.api.nvim_buf_get_lines(current_bufnr, 0, -1, false)
        local extended_lines = vim.list_extend(lines, lines_to_add)
        vim.api.nvim_buf_set_lines(current_bufnr, 0, -1, false, extended_lines)
    end

    if new_url_number then
        vim.api.nvim_exec("normal! a" .. "[" .. new_url_number .. "]", false)
    end
end

return M
