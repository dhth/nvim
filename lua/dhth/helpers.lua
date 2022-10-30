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

return M
