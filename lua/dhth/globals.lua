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
