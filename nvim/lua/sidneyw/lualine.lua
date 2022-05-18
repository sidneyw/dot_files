local lualine = require("lualine")
local tabline = require("tabline")
local notify = require("notify")

local chronoDir = vim.fn.expand("~/go/src/github.com/chronosphereio/")

tabline.setup({
	enable = true,
	options = {
		show_tabs_always = true,
	},
})

lualine.setup({
	options = { theme = "ayu_dark" },
	tabline = {
		lualine_x = { tabline.tabline_tabs },
		lualine_c = { tabline.tabline_buffers },
	},
})

local M = {}

function M.cwdTab(location, show_buffers)
	if show_buffers then
		tabline.toggle_show_all_buffers()
	end

	location = location or vim.fn.system("pwd")
	location = location .. "/"

	local basename = vim.fn.fnamemodify(location, ":p:h:t")

	basename = vim.fn.substitute(basename, "\n$", "", "")
	tabline.tab_rename(basename)
	-- tabline.toggle_show_all_buffers()
end

function M.tabcd(directory)
	-- if vim.fn.isdirectory(directory) ~= 1 then
	-- 	print(directory .. " is not a directory")
	-- 	notify(directory .. " is not a directory", "error")
	-- 	return
	-- end

	local p = directory .. "/README.md"
	print(p)
	tabline.tab_new(p)

	local ok = pcall(vim.cmd, "Glcd")
	if not ok then
		vim.cmd("lcd %:p:h")
	end

	M.cwdTab(directory, false)
end

function M.chronoTabcd(subdir)
	local location = chronoDir .. subdir
	M.tabcd(location)
end

nnoremap("]b", tabline.buffer_next)
nnoremap("[b", tabline.buffer_previous)

return M
