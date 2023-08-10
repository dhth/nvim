local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local git_helpers = require "dhth.git_helpers"

local M = {}

local function create_telescope_search(opts)
    local file_type = vim.bo.filetype
    local config
    if file_type == "scala" then
        config = {
            { "runMain" },
            { "docs/makeSite" },
            { "compile" },
            { "test" },
            { "compile;test" },
            { "test:compile" },
            { "reload;fbrdCompliance" },
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
        results_title = "commands",
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
                    if string.match(selection.value[1], "runMain") then
                        local mainFile = string.gsub((string.gsub(vim.fn.expand('%:r'), "src/main/scala/", "")), "/", ".")
                        vim.cmd('silent VimuxRunCommand("runMain ' .. mainFile .. '")')
                        vim.cmd('silent !tmux select-pane -t .+1 && tmux resize-pane -Z')
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
                    if string.match(selection.value[1], "runMain") then
                        local mainFile = string.gsub((string.gsub(vim.fn.expand('%:r'), "src/main/scala/", "")), "/", ".")
                        vim.cmd('silent VimuxRunCommand("runMain ' .. mainFile .. '")')
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
                    if string.match(selection.value[1], "runMain") then
                        local mainFile = string.gsub((string.gsub(vim.fn.expand('%:r'), "src/main/scala/", "")), "/", ".")
                        vim.cmd('silent VimuxRunCommand("runMain ' .. mainFile .. '")')
                        vim.cmd('silent !tmux resize-pane -Z')
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
    local opts = {
        layout_config = {
            height = .6,
            width = .4,
        }
    }
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
        { "ques", "QUES" },
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
    local packages = vim.fn.system([[cat ~/.config/nvim/lua/dhth/init.lua | grep "^require \"" | awk -F  "\"" '// {print $2}' | awk -F  "dhth." '// {print $2}']])
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

return M
