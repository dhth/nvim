local M = {}

function M.new_scratch_buffer()
    vim.cmd("execute 'vnew '")
    vim.cmd("setlocal buftype=nofile")
    vim.cmd("setlocal bufhidden=hide")
    vim.cmd("setlocal noswapfile")
end

function M.run_shell_command()
    vim.cmd([[:'<,'>!bash<CR>]])
    -- vim.cmd([[normal! ]])
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

function M.run_in_terminal()
    vim.cmd("normal! yip")
    local command = vim.fn.getreg('"')
    vim.cmd("terminal " .. command)
end

return M
