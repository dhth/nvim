local M = {}

function M.new_scratch_buffer()
    vim.cmd "execute 'vnew '"
    vim.cmd "setlocal buftype=nofile"
    vim.cmd "setlocal bufhidden=hide"
    vim.cmd "setlocal noswapfile"
end

function M.quit_vim()
    vim.fn.inputsave()
    local confirmation = vim.fn.input "restart? "

    if confirmation == "y" then
        vim.cmd "quitall"
    else
        print " cancelled"
    end
end

function M.run_in_terminal(opts)
    local yank_first

    yank_first = (opts and opts.yank_first) or false

    if yank_first then
        vim.cmd "normal! yip"
    end
    local command = vim.fn.getreg '"'
    vim.api.nvim_exec2("vsplit term://" .. command, { output = true })
end

--[=====[
try visually selecting the lines below (with v or Shift-V)
and calling the function below

pwd
tmux list-panes \
    -a \
    -F \
    '#{=40;p40:session_name} #{=20;p20:window_name}'
--]=====]
function M.run_shell_command()
    local start_line, start_col, end_line, end_col, bufnr =
        GET_VISUAL_SELECTION()
    local command = vim.fn.getreg '"'
    local last_line_of_selection =
        vim.api.nvim_buf_get_lines(bufnr, end_line - 1, end_line, false)
    if end_col > #last_line_of_selection[1] then
        -- must be a Shift-v selection, decrement end_col by 1
        end_col = end_col - 1
    end
    print("running...")
    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = function(_, data, _)
            table.remove(data, #data)
            vim.api.nvim_buf_set_text(
                bufnr,
                start_line - 1,
                start_col - 1,
                end_line - 1,
                end_col,
                data
            )
        end,
    })
end

-- WIP function to be able to replace visual selection with
-- the output of an interactive terminal command.
-- problem: new lines are separated with \r
-- leading to a ^M in the replaced text
function M.terminal_test()
    local start_line, start_col, end_line, end_col, bufnr =
        GET_VISUAL_SELECTION()
    vim.cmd.vnew()
    local command = vim.fn.getreg '"'
    vim.fn.termopen(command, {
        stdout_buffered = true,
        on_stdout = function(job, data, event)
            vim.api.nvim_buf_set_text(
                bufnr,
                start_line - 1,
                start_col - 1,
                end_line - 1,
                end_col - 1,
                data
            )
        end,
    })
end

--[=====[
try visually selecting the lines below (with v or Shift-V)
and calling the function below

for run in {1..2}; do echo "hi";sleep 2; done | pbcopy
read input;echo $input | pbcopy
--]=====]

function M.replace_visual_selection_with_clipboard_after_command()
    local start_line, start_col, end_line, end_col, bufnr =
        GET_VISUAL_SELECTION()
    local command = vim.fn.getreg '"'
    local last_line_of_selection =
        vim.api.nvim_buf_get_lines(bufnr, end_line - 1, end_line, false)
    if end_col > #last_line_of_selection[1] then
        -- must be a Shift-v selection, decrement end_col by 1
        end_col = end_col - 1
    end
    vim.cmd.vnew()
    vim.fn.termopen(command, {
        stdout_buffered = true,
        on_exit = function(_, exit_code, _)
            if exit_code == 0 then
                -- hopefully whatever command ran put the desired
                -- output text into the clipboard
                local replacement_text = SPLIT(vim.fn.getreg "+", "\n")
                vim.api.nvim_buf_set_text(
                    bufnr,
                    start_line - 1,
                    start_col - 1,
                    end_line - 1,
                    end_col,
                    replacement_text
                )
            end
        end,
    })
end

function M.run_quickrun()
    local command = "./.quickrun"
    vim.fn.jobstart(command, {
        stdout_buffered = false,
        on_stdout = function(_, data, _)
            if data[1] ~= "" then
                print(".quickrun: " .. data[1])
            end
        end,
        on_exit = function(_, exit_code, _)
            if exit_code == 1 then
                print ".quickrun failed"
            else
                print ".quickrun done"
            end
        end,
    })
end

function M.echo_buffer_path()
    local path = vim.fn.expand "%:h"
    vim.api.nvim_exec2("normal!i" .. path .. " ", { output = false })
end

--- .quickrun
NOREMAP_SILENT("n", ";`", M.run_quickrun)

NOREMAP_SILENT("i", "[p", M.echo_buffer_path)

--- Run visual selection via shell
NOREMAP_SILENT(
    "v",
    "r<c-r>",
    "y<cmd>lua require('custom.helpers.general.general').run_shell_command()<CR>"
)

--- Run visual selection in terminal
NOREMAP_SILENT(
    "v",
    "<c-t>",
    "y<cmd>lua require('custom.helpers.general').replace_visual_selection_with_clipboard_after_command()<CR>"
)

--- Run inner paragraph in terminal
NOREMAP_SILENT("n", "<leader>rt", function()
    M.run_in_terminal { yank_first = true }
end)

return M
