vim.opt.laststatus = 3

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = "*",
    callback = function(_)
        vim.cmd("startinsert")
    end
})
