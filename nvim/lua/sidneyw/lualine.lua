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

vim.cmd [[ nnoremap ]b :TablineBufferNext<CR> ]]
vim.cmd [[ nnoremap [b :TablineBufferPrevious<CR> ]]

local M = {}

function M.cwdTab()
	local basename = vim.fn.system("basename $(pwd)")
	basename = vim.fn.substitute(basename, "\n$", "", "")
	tabline.tab_rename(basename)
	tabline.toggle_show_all_buffers()
end

function M.tabcd(directory)
	if vim.fn.isdirectory(directory) ~= 1 then
		print(directory .. " is not a directory")
		notify(directory .. " is not a directory", "error")
		return
	end

	tabline.tab_new(directory .. "/.")

	local ok = pcall(vim.cmd, "Glcd")
	if not ok then vim.cmd("lcd %:p:h") end

	M.cwdTab()
end

return M
