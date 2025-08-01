local config = require("plugins.hurl.config")

local M = {}

function M.get_history_file()
  return config.options.save_directory .. "/history.json"
end

function M.load_history()
  local history_file = M.get_history_file()
  if vim.fn.filereadable(history_file) == 1 then
    local content = vim.fn.readfile(history_file)
    local ok, data = pcall(vim.fn.json_decode, table.concat(content, "\n"))
    if ok and type(data) == "table" then
      return data
    end
  end
  return {}
end

function M.save_history(history)
  vim.fn.mkdir(config.options.save_directory, "p")
  local history_file = M.get_history_file()
  local json_content = vim.fn.json_encode(history)
  vim.fn.writefile(vim.split(json_content, "\n"), history_file)
end

function M.add_to_history(entry)
  local history = M.load_history()
  table.insert(history, 1, entry) -- Add to beginning
  
  -- Limit history size
  if #history > config.options.max_history_entries then
    table.remove(history, #history)
  end
  
  M.save_history(history)
end

function M.clear_history()
  M.save_history({})
  vim.notify("Hurl history cleared")
end

return M