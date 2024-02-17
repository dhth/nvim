local M = {}

function M.new_scratch_buffer()
    vim.cmd("execute 'vnew '")
    vim.cmd("setlocal buftype=nofile")
    vim.cmd("setlocal bufhidden=hide")
    vim.cmd("setlocal noswapfile")
end

function M.quit_vim()
    vim.fn.inputsave()
    local confirmation = vim.fn.input("restart? ")

    if (confirmation == "y")
    then
        vim.cmd("quitall")
    else
        print(" cancelled")
    end
end

function M.run_in_terminal(opts)
    local yank_first

    yank_first = (opts and opts.yank_first) or false

    if yank_first then
        vim.cmd("normal! yip")
    end
    local command = vim.fn.getreg('"')
    vim.api.nvim_exec2("vsplit term://" .. command, { output = true })
end

local function get_visual_selection()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local start_col = vim.fn.col("'<")
    local end_col = vim.fn.col("'>")
    local bufnr = vim.fn.bufnr('%')

    return start_line, start_col, end_line, end_col, bufnr
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
    local start_line, start_col, end_line, end_col, bufnr = get_visual_selection()
    local command = vim.fn.getreg('"')
    local last_line_of_selection = vim.api.nvim_buf_get_lines(bufnr, end_line - 1, end_line, false)
    if end_col > #last_line_of_selection[1] then
        -- must be a Shift-v selection, decrement end_col by 1
        end_col = end_col - 1
    end
    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = function(job_id, data, event_type)
            table.remove(data, #data)
            vim.api.nvim_buf_set_text(bufnr, start_line - 1, start_col - 1, end_line - 1, end_col,
                data)
        end
    })
end

-- WIP function to be able to replace visual selection with
-- the output of an interactive terminal command.
-- problem: new lines are separated with \r
-- leading to a ^M in the replaced text
function M.terminal_test()
    local start_line, start_col, end_line, end_col, bufnr = get_visual_selection()
    vim.cmd.vnew()
    local command = vim.fn.getreg('"')
    vim.fn.termopen(command, {
        stdout_buffered = true,
        on_stdout = function(job, data, event)
            vim.api.nvim_buf_set_text(bufnr, start_line - 1, start_col - 1, end_line - 1, end_col - 1, data)
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
    local start_line, start_col, end_line, end_col, bufnr = get_visual_selection()
    local command = vim.fn.getreg('"')
    local last_line_of_selection = vim.api.nvim_buf_get_lines(bufnr, end_line - 1, end_line, false)
    if end_col > #last_line_of_selection[1] then
        -- must be a Shift-v selection, decrement end_col by 1
        end_col = end_col - 1
    end
    vim.cmd.vnew()
    vim.fn.termopen(command, {
        stdout_buffered = true,
        on_exit = function(job_id, exit_code, event_type)
            if exit_code == 0 then
                -- hopefully whatever command ran put the desired
                -- output text into the clipboard
                local replacement_text = SPLIT(vim.fn.getreg('+'), "\n")
                vim.api.nvim_buf_set_text(bufnr, start_line - 1, start_col - 1, end_line - 1, end_col,
                    replacement_text)
            end
        end
    })
end

return M
