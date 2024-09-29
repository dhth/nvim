local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local theme = require("telescope.themes").get_ivy
local job = require "plenary.job"

local M = {}

local function parse_golangci_lint_output(output)
    local entries = {}
    for _, line in ipairs(output) do
        local filepath, lnum, col, message =
            line:match "([^:]+):(%d+):(%d+): (.+)"
        if filepath and lnum and col and message then
            table.insert(entries, {
                filename = filepath,
                lnum = tonumber(lnum),
                col = tonumber(col),
                text = message,
            })
        end
    end
    return entries
end

local function run_and_show_lint_results()
    -- https://github.com/nvim-lua/plenary.nvim#plenaryjob
    job:new({
        command = "golangci-lint",
        args = { "run" },
        on_start = function()
            print "running..."
        end,
        on_exit = function(j, code)
            vim.schedule(function()
                if code == 0 then
                    print "all good"
                    return
                end

                local entries = parse_golangci_lint_output(j:result())
                SETQF(entries)
            end)
        end,
    }):start()
end

function M.golangci()
    run_and_show_lint_results()
end

local function go_run(switch_to_pane)
    local command = "go run " .. vim.fn.expand "%"
    vim.cmd('silent VimuxRunCommand("' .. command .. '")')

    if switch_to_pane then
        vim.cmd "silent !tmux select-pane -t .+1 && tmux resize-pane -Z"
    end
end

local function create_telescope_search(opts)
    local file_type = vim.bo.filetype
    local config
    config = {
        { "go build ." },
        { "go run ." },
        { "gofmt -w ." },
        { "golangci-lint run" },
        { "go test ." },
        { "go test ./..." },
        { "gotestdox ./..." },
        { "go test . -v" },
        { "go test ./... -v" },
    }

    pickers
        .new(opts, {
            prompt_title = "~ " .. file_type .. " ~",
            finder = finders.new_table {
                results = config,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry[1],
                        ordinal = entry[1],
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    if string.match(selection.value[1], "go run .") then
                        go_run(true)
                    -- TODO: this doesn't work for strings with dashes; fix this
                    elseif string.match(selection.value[1], "golangci") then
                        M.golangci()
                    else
                        vim.cmd(
                            'silent VimuxRunCommand("'
                                .. selection.value[1]
                                .. '")'
                        )
                        vim.cmd "silent !tmux select-pane -t .+1 && tmux resize-pane -Z"
                    end
                end)
                actions.select_tab:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    if string.match(selection.value[1], "go run") then
                        go_run(true)
                    else
                        vim.cmd(
                            'silent VimuxRunCommand("'
                                .. selection.value[1]
                                .. '")'
                        )
                    end
                    print("sent: " .. selection.value[1] .. " ⚡️")
                end)
                actions.select_vertical:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    if string.match(selection.value[1], "go run") then
                        go_run(true)
                    else
                        vim.cmd(
                            'silent VimuxRunCommand("'
                                .. selection.value[1]
                                .. '")'
                        )
                        vim.cmd "silent !tmux resize-pane -Z"
                    end
                end)
                return true
            end,
        })
        :find()
end

function M.commands()
    local opts = theme {
        results_title = false,
        layout_config = {
            height = 0.6,
        },
    }
    create_telescope_search(opts)
end

return M
