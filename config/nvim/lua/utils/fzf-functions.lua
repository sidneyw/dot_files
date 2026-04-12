local M = {}

-- Project files: git_files with fallback to find_files
M.project_files = function(opts)
  opts = opts or {}
  local fzf = require("fzf-lua")

  -- Check if we're in a git repo
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null")
  if vim.v.shell_error == 0 and git_root ~= "" then
    fzf.git_files(opts)
  else
    fzf.files(opts)
  end
end

-- Search dotfiles
M.search_dotfiles = function()
  require("fzf-lua").files({
    prompt = "<Dot Files Search> ",
    cwd = "~/.dot_files",
    hidden = true,
  })
end

-- Open git file from clipboard
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

  -- Otherwise, fall back to fzf-lua
  local ok = pcall(require("fzf-lua").git_files, {
    query = clipboard_content,
  })
  if not ok then
    vim.notify("Failed to open fzf-lua", vim.log.levels.ERROR)
  end
end

-- Luasnip snippets picker
M.luasnip_snippets = function()
  local fzf = require("fzf-lua")
  local ok, luasnip = pcall(require, "luasnip")
  if not ok then
    vim.notify("Luasnip not installed", vim.log.levels.ERROR)
    return
  end

  local ft = vim.bo.filetype
  local available_snippets = luasnip.get_snippets(ft) or {}
  local all_snippets = luasnip.get_snippets("all") or {}

  -- Combine filetype-specific and global snippets
  local snippets = {}
  for _, snip in ipairs(available_snippets) do
    table.insert(snippets, snip)
  end
  for _, snip in ipairs(all_snippets) do
    table.insert(snippets, snip)
  end

  if #snippets == 0 then
    vim.notify("No snippets available for filetype: " .. ft, vim.log.levels.INFO)
    return
  end

  -- Format snippets for fzf
  local items = {}
  for _, snip in ipairs(snippets) do
    local trigger = snip.trigger or ""
    local name = snip.name or ""
    local description = snip.description and table.concat(snip.description, " ") or ""
    table.insert(items, string.format("%s\t%s\t%s", trigger, name, description))
  end

  fzf.fzf_exec(items, {
    prompt = "Snippets> ",
    winopts = {
      height = 0.6,
      width = 0.8,
    },
    fzf_opts = {
      ["--delimiter"] = "\t",
      ["--with-nth"] = "1,2,3",
    },
    actions = {
      ["default"] = function(selected)
        if selected and #selected > 0 then
          local trigger = selected[1]:match("^([^\t]+)")
          if trigger then
            -- Insert the trigger and expand
            vim.api.nvim_put({ trigger }, "c", true, true)
            vim.schedule(function()
              luasnip.expand()
            end)
          end
        end
      end,
    },
  })
end

return M
