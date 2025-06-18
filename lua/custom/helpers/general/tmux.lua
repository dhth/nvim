local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local theme = require("telescope.themes").get_ivy
local action_state = require "telescope.actions.state"
local Job = require "plenary.job"

local CMDS_FILE = ".cmds"

local M = {}

local function get_tmux_pane_command(pane)
    local job = Job:new {
        command = "tmux",
        args = {
            "display-message",
            "-t",
            pane,
            "-p",
            "#{pane_current_command}",
        },
    }
    job:sync()
    return job:result()[1]
end

local function free_window_available()
    local target = "2"
    local cmd = get_tmux_pane_command ":2"
    local running_cmds = {}

    if cmd ~= "zsh" then
        table.insert(running_cmds, cmd)
        cmd = get_tmux_pane_command ":3"
        if cmd ~= "zsh" then
            table.insert(running_cmds, cmd)
            return target, running_cmds, false
        end
        target = "3"
    end
    return target, running_cmds, true
end

function M.cmds()
    local opts = theme {
        prompt_title = "~ cmds ~",
        results_title = false,
        layout_config = {
            height = 0.6,
        },
    }

    if not DOES_FILE_EXIST(CMDS_FILE) then
        print "no commands"
        return
    end

    local cmds = READ_FILE_LINES(CMDS_FILE)
    if #cmds == 0 then
        print "no commands in cmds file"
        return
    end

    local target, running_cmds, free = free_window_available()
    if not free then
        local cmds_running = running_cmds[1]
        for i = 2, #running_cmds do
            cmds_running = cmds_running .. " & " .. running_cmds[i]
        end
        print("cmds already running: " .. cmds_running)
        return
    end

    pickers
        .new(opts, {
            finder = require("telescope.finders").new_table {
                results = cmds,
            },
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    if selection ~= nil then
                        local selected_cmd = selection[1]
                        Job
                            :new({
                                command = "tmux",
                                args = {
                                    "send-keys",
                                    "-t",
                                    ":" .. target,
                                    selected_cmd,
                                    "Enter",
                                },
                            })
                            :sync()
                        Job
                            :new({
                                command = "tmux",
                                args = { "switch-client", "-t", ":" .. target },
                            })
                            :sync()
                    end
                end)
                return true
            end,
        })
        :find()
end

local predefined_cmds = {
    rust = {
        "cargo check --all-targets",
        "cargo build",
        "cargo run",
        "cargo test",
        "cargo fmt --all",
        "cargo clippy --all-targets",
    },
    go = {
        "go run .",
        "go test ./...",
    },
}

function M.quickrun(num)
    local cmds
    if not DOES_FILE_EXIST(CMDS_FILE) then
        local ft = vim.bo.filetype
        cmds = predefined_cmds[ft]
    else
        cmds = READ_FILE_LINES(CMDS_FILE)
    end

    if not cmds then
        print "no commands"
        return
    end

    local target, running_cmds, free = free_window_available()
    if not free then
        local cmds_running = running_cmds[1]
        for i = 2, #running_cmds do
            cmds_running = cmds_running .. " & " .. running_cmds[i]
        end
        print("cmds already running: " .. cmds_running)
        return
    end

    local selected_cmd = cmds[num]

    Job:new({
        command = "tmux",
        args = { "send-keys", "-t", ":" .. target, selected_cmd, "Enter" },
    }):sync()
    Job:new({
        command = "tmux",
        args = { "switch-client", "-t", ":" .. target },
    }):sync()
end

function M.quickrun_popup(num)
    local cmds
    if not DOES_FILE_EXIST(CMDS_FILE) then
        local ft = vim.bo.filetype
        cmds = predefined_cmds[ft]
    else
        cmds = READ_FILE_LINES(CMDS_FILE)
    end

    if not cmds then
        print "no commands"
        return
    end

    local selected_cmd = cmds[num]

    Job:new({
        command = "tmux",
        args = {
            "display-popup",
            "-h",
            "60%",
            "-w",
            "100%",
            "-y",
            "50%",
            "-S",
            "fg=#928374",
            selected_cmd,
        },
    }):start()
end

--- cmds
NOREMAP_SILENT("n", ";;", M.cmds)

--- quickrun 1-4
for i = 1, 4 do
    NOREMAP_SILENT("n", ";" .. i, function()
        M.quickrun(i)
    end)
end

--- quickrun(1)
NOREMAP_SILENT("n", "e<c-e>", function(i)
    M.quickrun(i)
end)

--- quickrun popup 1-4
for i = 1, 4 do
    NOREMAP_SILENT("n", "," .. i, function()
        M.quickrun_popup(i)
    end)
end

return M
