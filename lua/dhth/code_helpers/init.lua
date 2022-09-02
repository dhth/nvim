local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

local function create_telescope_search(opts)
    local file_type = vim.bo.filetype
    local config
    if file_type == "scala" then
        config = {
            { "runMain" },
            { "compile" },
            { "test" },
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
    elseif file_type == "fugitive" then
        config = {
            { "diff", "DiffviewOpen" },
            { "diff cached", "DiffviewOpen --cached" },
        }

    else
        print("nothing configured for filetype")
        return
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

return M
