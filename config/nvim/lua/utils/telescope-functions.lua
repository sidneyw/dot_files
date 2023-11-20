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

return M
