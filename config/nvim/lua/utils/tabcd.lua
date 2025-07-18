local tabline = require("tabline")
local notify = require("snacks").notify
local wk = require("which-key")
local telescopeCustom = require("utils.telescope-functions")

local dotFilesDir = vim.fn.expand("~/.dot_files/")
local codeDir = vim.fn.expand("~/Code/")
local logseqDir = vim.fn.expand("~/Library/Mobile Documents/iCloud~com~logseq~logseq/Documents")

local M = {}

function M.Rename(location, skipRename)
  skipRename = skipRename or false
  M.show_tab_buffers()

  location = location or vim.fn.system("pwd")
  location = location .. "/"

  local basename = vim.fn.fnamemodify(location, ":p:h:t")

  if not skipRename then
    basename = vim.fn.substitute(basename, "\n$", "", "")
    tabline.tab_rename(basename)
  end
end

function M.New(directory, skipRename)
  if vim.fn.isdirectory(directory) ~= 1 then
    notify.error(directory .. " is not a directory")
    return
  end

  local p = directory .. "/."
  tabline.tab_new(p)

  local ok = pcall(vim.cmd, "Glcd")
  if not ok then
    vim.cmd("lcd %:p:h")
  end

  M.Rename(directory, skipRename)
  os.execute("sleep 0.3")
  telescopeCustom.project_files()
end

function M.NewCode(subdir)
  local location = codeDir .. subdir
  M.New(location)
end

function M.show_tab_buffers()
  local data = vim.t.tabline_data
  data.show_all_buffers = false
  vim.t.tabline_data = data
  vim.cmd([[redrawtabline]])
end

wk.add({
  {
    "<leader>em",
    function()
      M.NewCode("clay-base")
    end,
    desc = "clay-base",
  },
  {
    "<leader>ed",
    function()
      M.NewCode("clay-base/dagster-pipelines")
    end,
    desc = "clay-base",
  },
  {
    "<leader>ep",
    function()
      M.NewCode("public-actions")
    end,
    desc = "public actions",
  },
  {
    "<leader>ev",
    function()
      M.New(dotFilesDir, true)
      tabline.tab_rename("DotFiles")
    end,
    desc = "Dotfiles",
  },
  {
    "<leader>el",
    function()
      M.New(logseqDir, true)
      tabline.tab_rename("Logseq")
    end,
  },
  {
    "<leader>te",
    function()
      tabline.tab_new("%")
    end,
    desc = "Open new tab with current file",
  },
})

-- Name the tab when vim starts up
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.fn.timer_start(200, function()
      if vim.bo.filetype == "snacks_dashboard" then
        return
      end
      M.Rename(false)
    end)
  end,
  desc = "Rename the tab with the current directory basename",
})

vim.api.nvim_create_user_command("TabCD", function(args)
  M.New(args.fargs[1], false)
end, {
  nargs = 1,
  complete = "dir",
  desc = "TabCD",
})

vim.api.nvim_create_user_command("TabDirName", function()
  M.Rename(false)
end, {
  nargs = 0,
  desc = "Rename the current tab with the directory basename",
})

vim.cmd([[
	cnoreabbr tabcd TabCD
	cnoreabbr tcd TabCD
	cnoreabbr trn TablineTabRename
  cnoreabbr tdn TabDirName
]])

return M
