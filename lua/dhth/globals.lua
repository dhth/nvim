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
    require("notify")(body, "info", { title = title or "notification"})
end


NOTIFP = function(body, title)
    NOTIF(vim.inspect(body), title)
end

REMAP = function(...) vim.api.nvim_set_keymap(...) end

SPLIT = function (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

TRIM = function (s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

SPLIT_STRING = function (input_str, delimiter)
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


RANDOMCHARS = function (length)
    local charset = "0123456789abcdefghijklmnopqrstuvwxyz"
    local randomString = ""
    math.randomseed(os.time())
    for i = 1, length do
        local randIndex = math.random(1, #charset)
        randomString = randomString .. string.sub(charset, randIndex, randIndex)
    end
    return randomString
end
