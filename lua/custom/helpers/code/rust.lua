local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local theme = require("telescope.themes").get_ivy
local job = require "plenary.job"

local M = {}

local function parse_cargo_clippy_output(output)
    local entries = {}
    local current_file = nil
    for _, line in ipairs(output) do
        local filepath, lnum, col, message =
            line:match "^%s*-->%s*([^:]+):(%d+):(%d+)%s*(.+)"
        if filepath and lnum and col and message then
            current_file = filepath
            table.insert(entries, {
                filename = filepath,
                lnum = tonumber(lnum),
                col = tonumber(col),
                text = message,
            })
        elseif current_file and line:match "^%s*=%s*note:" then
            -- Skip note lines
        elseif current_file and line:match "^%s*=%s*help:" then
            -- Skip help lines
        elseif current_file and line:match "^%s*%|%s*" then
            -- Skip lines that are part of the error context
        elseif current_file and line:match "^%s*%w" then
            -- Append additional message lines to the last entry
            entries[#entries].text = entries[#entries].text
                .. " "
                .. line:match "^%s*(.+)"
        end
    end
    return entries
end

local function run_and_show_clippy_results()
    local result = {}
    job:new({
        command = "cargo",
        args = { "clippy" },
        on_start = function()
            print "running cargo clippy..."
        end,
        on_exit = function(_, _)
            vim.schedule(function()
                local has_warnings = false
                for _, line in ipairs(result) do
                    if line:match "^warning:" or line:match "^error:" then
                        has_warnings = true
                        break
                    end
                end

                if not has_warnings then
                    print "all good"
                    return
                end

                local entries = parse_cargo_clippy_output(result)
                if #entries > 0 then
                    vim.fn.setqflist(entries)
                    vim.cmd "copen"
                else
                    print "all good"
                end
            end)
        end,
        on_stdout = function(_, data)
            table.insert(result, data)
        end,
        on_stderr = function(_, data)
            table.insert(result, data)
        end,
    }):start()
end

function M.cargo_clippy()
    run_and_show_clippy_results()
end

local function create_telescope_search(opts)
    local file_type = vim.bo.filetype
    local config
    config = {
        { "cargo build" },
        { "cargo test" },
        { "cargo run" },
        { "cargo fmt --all" },
        { "cargo clippy" },
        { "cargo test" },
        { "cargo install --path ." },
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

                    if string.match(selection.value[1], "clippy") then
                        M.cargo_clippy()
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

                    vim.cmd(
                        'silent VimuxRunCommand("' .. selection.value[1] .. '")'
                    )
                    print("sent: " .. selection.value[1] .. " ⚡️")
                end)
                actions.select_vertical:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    vim.cmd(
                        'silent VimuxRunCommand("' .. selection.value[1] .. '")'
                    )
                    vim.cmd "silent !tmux resize-pane -Z"
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
