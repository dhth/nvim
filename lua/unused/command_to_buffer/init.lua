local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

local function stream_output_to_buffer(cmd)
    vim.cmd "vsplit"
    vim.cmd "setlocal buftype=nofile"
    vim.cmd "setlocal bufhidden=hide"
    local win = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(win, bufnr)
    -- print(bufnr)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
        "running",
        cmd,
        "...",
        "",
    })

    vim.fn.jobstart(SPLIT(cmd, " "), {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
        on_stderr = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
            end
        end,
    })
end

local function create_telescope_search(opts)
    pickers
        .new(opts, {
            prompt_title = "colors",
            finder = finders.new_table {
                results = {
                    "sbt compile",
                    "sbt test",
                },
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry,
                        ordinal = entry,
                    }
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    stream_output_to_buffer(selection.value)
                end)
                return true
            end,
        })
        :find()
end

function M.run_command_in_vsplit()
    local opts = {
        prompt_title = "~ scala ~",
        layout_config = {
            height = 0.5,
            width = 0.4,
        },
    }
    create_telescope_search(opts)
end

return M
