local tabline = require("tabline")
local notify = require("notify")
local wk = require("which-key")
local telescopeCustom = require("utils.telescope-functions")

local dotFilesDir = vim.fn.expand("~/.dot_files/")
local chronoDir = vim.fn.expand("~/go/src/github.com/chronosphereio/")

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
    print(directory .. " is not a directory")
    notify(directory .. " is not a directory", "error")
    return
  end

  local p = directory .. "/."
  tabline.tab_new(p)

  local ok = pcall(vim.cmd, "Glcd")
  if not ok then
    vim.cmd("lcd %:p:h")
  end

  M.Rename(directory, skipRename)
  telescopeCustom.project_files()
end

function M.NewChrono(subdir)
  local location = chronoDir .. subdir
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
      M.NewChrono("monorepo")
    end,
    desc = "Monorepo",
  },
  {
    "<leader>ee",
    function()
      M.NewChrono("envconfig")
    end,
    desc = "Environment Config",
  },
  {
    "<leader>ec",
    function()
      M.NewChrono("collector")
    end,
    desc = "Collector",
  },
  {
    "<leader>ei",
    function()
      M.NewChrono("infrastructure")
    end,
    desc = "Infrastructure",
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
      -- print out the current buffer name and filetype
      if vim.bo.filetype == "dashboard" then
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
