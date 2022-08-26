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
