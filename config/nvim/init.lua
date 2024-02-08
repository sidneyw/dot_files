local ok, plenary_reload = pcall(require, "plenary.reload")
if not ok then
  RELOADER = require
else
  RELOADER = plenary_reload.reload_module
end

RELOAD = function(...)
  return RELOADER(...)
end

R = function(name)
  RELOAD(name)
  print("Reloaded module:", name)
  return require(name)
end

P = function(v)
  print(vim.inspect(v))
  return v
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("utils.tabcd")
