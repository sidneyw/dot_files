local lualine = require"lualine"
local tabline = require"tabline"
local notify = require"notify"

tabline.setup {
  enable = true,
  options = {
    show_tabs_always = true,
  }
}

lualine.setup{
  options = {theme = "ayu_dark"},
  tabline = {
    lualine_x = { tabline.tabline_tabs },
    lualine_c = { tabline.tabline_buffers },
  },
}

local M = {}

M.tabcd = function (directory)
	if vim.fn.isdirectory(directory) ~= 1 then
		print(directory .. " is not a directory")
		notify(directory .. " is not a directory", "error")
		return
	end

	tabline.tab_new(directory .. "/.")
	local newDirName = vim.fn.expand("%:p:h:t")

	tabline.tab_rename(newDirName)

  local ok = pcall(vim.cmd, "Glcd")
	if not ok then vim.cmd("lcd %:p:h") end
end

M.cwdTab = function ()
	local basename = vim.fn.system("basename $(pwd)")
	basename = vim.fn.substitute(basename, "\n$", "", "")
	tabline.tab_rename(basename)
	tabline.toggle_show_all_buffers()
end

return M
