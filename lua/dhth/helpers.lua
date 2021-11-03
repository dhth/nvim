local M = {}

function M.new_scratch_buffer()
    vim.cmd("execute 'vnew '")
    vim.cmd("setlocal buftype=nofile")
    vim.cmd("setlocal bufhidden=hide")
    vim.cmd("setlocal noswapfile")
end

return M
