local M = {}

local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function mysplit (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

local function failed_test_details (inputstr)
    local file_name = mysplit(mysplit(inputstr, " ")[2], ":")[1]
    local lnum = mysplit(inputstr, ":")[2]
    local col = mysplit(inputstr, ":")[3]
    local text = trim(mysplit(inputstr, ":")[4])

    return {
        filename = file_name,
        lnum = lnum,
        col = col,
        text = text,
    }
end

local function get_failed_test_summary(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = failed_test_details(line)
    end
    return lines
end


function M.run_sbt_compile()
    print("Running sbt compile...")
    vim.cmd('Dispatch! sbt compile | grep \'\\[error\\] \\/.*: \' | tee compileerrors')
end

-- nvim-metals does this built in
function M.compile_errors_to_quickfix()
    -- print("Running sbt compile...")
    -- vim.cmd('silent !sbt compile | grep \'\\[error\\] \\/.*: \' | tee compileerrors')
    local qf = get_failed_test_summary('compileerrors')
    if next(qf) then
        vim.fn.setqflist({}, 'r', {title="Compile Errors 🙁 ", items=qf})
        vim.cmd("copen")
    end
end

return M
