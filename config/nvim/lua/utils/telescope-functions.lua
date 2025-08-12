local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local M = {}

M.project_files = function(opts)
  opts = opts or {}
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "<Dot Files Search>",
    cwd = "~/.dot_files",
    hidden = true,
  })
end

M.open_git_file_from_clipboard = function()
  local clipboard_content = vim.fn.getreg("+")

  if clipboard_content == "" then
    vim.notify("Clipboard is empty", vim.log.levels.WARN)
    return
  end

  -- Clean up clipboard content (remove newlines, trim whitespace)
  clipboard_content = clipboard_content:gsub("\n", ""):gsub("^%s*(.-)%s*$", "%1")

  -- Get git root directory
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
  if vim.v.shell_error ~= 0 then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  -- Check for exact match using git ls-files + grep
  local grep_cmd = string.format("git ls-files | grep -Fx %s", vim.fn.shellescape(clipboard_content))
  local raw_matches = vim.fn.system(grep_cmd)
  local matches = raw_matches:gsub("\n*$", "")
  local exit_code = vim.v.shell_error

  -- If exactly one match found (exit code 0 and single line)
  if exit_code == 0 and matches ~= "" and not matches:find("\n") then
    local file_path = git_root .. "/" .. matches
    vim.cmd.edit(file_path)
    return
  end

  -- Otherwise, fall back to telescope
  local opts = {
    default_text = clipboard_content,
  }

  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    vim.notify("Failed to open telescope", vim.log.levels.ERROR)
  end
end

return M
