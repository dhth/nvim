local dap = require "dap"

dap.configurations.scala = {
    {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = {
            runType = "runOrTestFile",
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
        },
    },
    {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
            runType = "testTarget",
        },
    },
}

local opts = { noremap = true, silent = true }

REMAP(
    "n",
    "<Leader>bb",
    "<cmd>lua require('dap').toggle_breakpoint()<CR>",
    opts
)

REMAP("n", "<Leader>dd", "<cmd>lua require('dap').continue()<CR>", opts)

-- REMAP(
--     'n',
--     '[s',
--     "<cmd>lua require('dap').step_into()<CR>",
--     opts
-- )
--
-- REMAP(
--     'n',
--     ']s',
--     "<cmd>lua require('dap').step_over()<CR>",
--     opts
-- )

REMAP("n", "<Leader>db", "<cmd>lua require('dap').repl.open()<CR>", opts)
