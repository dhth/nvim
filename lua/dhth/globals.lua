P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

NOTIF = function(body, title)
    require("notify")(body, "info", { title = title or "notification" })
end


NOTIFP = function(body, title)
    NOTIF(vim.inspect(body), title)
end

REMAP = function(...) vim.api.nvim_set_keymap(...) end

SPLIT = function(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

TRIM = function(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

SPLIT_STRING = function(input_str, delimiter)
    local result = {}
    local start = 1

    while true do
        local pos = input_str:find(delimiter, start, true)
        if not pos then
            table.insert(result, input_str:sub(start))
            break
        end

        table.insert(result, input_str:sub(start, pos - 1))
        start = pos + #delimiter
    end

    return result
end

ENDSWITH = function (str, suffix)
    return string.sub(str, -string.len(suffix)) == suffix
end


RANDOMCHARS = function(length)
    local charset = "0123456789abcdefghijklmnopqrstuvwxyz"
    local randomString = ""
    math.randomseed(os.time())
    for i = 1, length do
        local randIndex = math.random(1, #charset)
        randomString = randomString .. string.sub(charset, randIndex, randIndex)
    end
    return randomString
end

DOES_FILE_EXIST = function(filePath)
    local file = io.open(filePath, "r")
    if file then
        io.close(file)
        return true
    else
        return false
    end
end

DOES_DIRECTORY_EXIST = function (directory)
    local directory_expanded = vim.fn.expand(directory)
    local stat = vim.loop.fs_stat(directory_expanded)
    if not stat then
        return false
    end
    return stat and stat.type == 'directory'
end

CURRENT_BUFFER_NUMBER = function()
    local current_winnr = vim.api.nvim_get_current_win()

    local current_bufnr = vim.api.nvim_win_get_buf(current_winnr)
    return current_bufnr
end

GET_LINES_FROM_FILE = function(file)
    if not DOES_FILE_EXIST(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = SPLIT(line, "::")
    end
    return lines
end


SLEEP = function(seconds, callback)
    vim.defer_fn(callback, seconds * 1000)
end
