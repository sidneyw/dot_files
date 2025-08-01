local M = {}

function M.get_bookmarks_file()
  return vim.fn.getcwd() .. "/.hurl_bookmarks.json"
end

function M.load_bookmarks()
  local bookmarks_file = M.get_bookmarks_file()
  if vim.fn.filereadable(bookmarks_file) == 1 then
    local content = vim.fn.readfile(bookmarks_file)
    local ok, data = pcall(vim.fn.json_decode, table.concat(content, "\n"))
    if ok and type(data) == "table" then
      return data
    end
  end
  return {}
end

function M.save_bookmarks(bookmarks)
  local bookmarks_file = M.get_bookmarks_file()
  local json_content = vim.fn.json_encode(bookmarks)
  vim.fn.writefile(vim.split(json_content, "\n"), bookmarks_file)
end

function M.add_bookmark(name, description)
  local bookmarks = M.load_bookmarks()
  local current_file = vim.fn.expand("%:p")
  local line_number = vim.fn.line(".")
  
  bookmarks[name] = {
    file_path = current_file,
    line_number = line_number,
    description = description or "",
    created_at = os.time(),
  }
  
  M.save_bookmarks(bookmarks)
  vim.notify("Bookmark '" .. name .. "' added")
end

function M.remove_bookmark(name)
  local bookmarks = M.load_bookmarks()
  if bookmarks[name] then
    bookmarks[name] = nil
    M.save_bookmarks(bookmarks)
    vim.notify("Bookmark '" .. name .. "' removed")
  else
    vim.notify("Bookmark '" .. name .. "' not found", vim.log.levels.WARN)
  end
end

function M.list_bookmarks()
  return M.load_bookmarks()
end

return M