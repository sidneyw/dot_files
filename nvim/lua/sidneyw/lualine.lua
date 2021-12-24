local lualine = require'lualine'
local tabline = require'tabline'

tabline.setup {
  enable = true,
  options = {
    show_tabs_always = true,
  }
}

lualine.setup{
  -- options = {theme = 'ayu_dark'},
  options = {theme = 'ayu_mirage'},
  tabline = {
    lualine_x = { tabline.tabline_tabs },
    lualine_c = { tabline.tabline_buffers },
  },
}

local M = {}

M.tabcd = function (directory)
	if vim.fn.isdirectory(directory) ~= 1 then
		error(directory .. " is not directory")
		return
	end

	tabline.tab_new(directory .. "/.")
	local newDirName = vim.fn.expand("%:p:h:t")

	tabline.tab_rename(newDirName)
	vim.cmd("Glcd")
end

M.cwdTab = function ()
	local basename = vim.fn.system("basename $(pwd)")
	basename = vim.fn.substitute(basename, "\n$", "", "")
	tabline.tab_rename(basename)
end

return M
