local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local theme = require('telescope.themes').get_ivy
local action_state = require "telescope.actions.state"
local Job = require('plenary.job')

local CMDS_FILE = ".cmds"

local M = {}

local function get_tmux_pane_command(pane)
    local job = Job:new({
        command = "tmux",
        args = { "display-message", "-t", pane, "-p", "#{pane_current_command}" },
    })
    job:sync()
    return job:result()[1]
end

function M.cmds()
    local opts = theme({
        prompt_title = "~ cmds ~",
        results_title = false,
        layout_config = {
            height = .6,
        },
    })
    if DOES_FILE_EXIST(CMDS_FILE) then
        local target = "2"
        local cmd = get_tmux_pane_command(":2")
        local running_cmds = {}

        if cmd ~= "zsh" then
            table.insert(running_cmds, cmd)
            cmd = get_tmux_pane_command(":3")
            if cmd ~= "zsh" then
                table.insert(running_cmds, cmd)
                print("cmds already running: " .. running_cmds[1] .. " & " .. running_cmds[2])
                return
            end
            target = "3"
        end

        local cmds = READ_FILE_LINES(CMDS_FILE)
        if #cmds == 0 then
            print("no commands in cmds file")
            return
        end

        pickers.new(opts, {
            finder = require('telescope.finders').new_table {
                results = cmds
            },
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    if selection ~= nil then
                        local selected_cmd = selection[1]
                        Job:new({
                            command = "tmux",
                            args = { "send-keys", "-t", ":" .. target, selected_cmd, "Enter" },
                        }):sync()
                        Job:new({
                            command = "tmux",
                            args = { "switch-client", "-t", ":" .. target },
                        }):sync()
                    end
                end)
                return true
            end,
        }):find()
    else
        print("no commands")
    end
end

return M
