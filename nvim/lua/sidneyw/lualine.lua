local lualine = require("lualine")
local tabline = require("tabline")
local notify = require("notify")
local telescopeCustom = require("sidneyw.telescope")

local dotFilesDir = vim.fn.expand("~/.dot_files/")
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

function M.cwdTab(location, show_buffers, skipRename)
	skipRename = skipRename or false
	if show_buffers then
		tabline.toggle_show_all_buffers()
	end

	location = location or vim.fn.system("pwd")
	location = location .. "/"

	local basename = vim.fn.fnamemodify(location, ":p:h:t")

	if not skipRename then
		basename = vim.fn.substitute(basename, "\n$", "", "")
		tabline.tab_rename(basename)
	end
end

function M.tabcd(directory, skipRename)
	if vim.fn.isdirectory(directory) ~= 1 then
		print(directory .. " is not a directory")
		notify(directory .. " is not a directory", "error")
		return
	end

	-- local p = directory .. "/README.md"
	local p = directory .. "/."
	tabline.tab_new(p)

	local ok = pcall(vim.cmd, "Glcd")
	if not ok then
		vim.cmd("lcd %:p:h")
	end

	M.cwdTab(directory, false, skipRename)
	telescopeCustom.project_files()
end

function M.chronoTabcd(subdir)
	local location = chronoDir .. subdir
	M.tabcd(location)
end

nnoremap("]b", tabline.buffer_next)
nnoremap("[b", tabline.buffer_previous)

local function jumpPrefix(key)
	return "<leader>e" .. key
end

nnoremap(jumpPrefix("m"), function()
	M.chronoTabcd("monorepo")
end)

nnoremap(jumpPrefix("e"), function()
	M.chronoTabcd("envconfig")
end)

nnoremap(jumpPrefix("c"), function()
	M.chronoTabcd("collector")
end)

nnoremap(jumpPrefix("v"), function()
	M.tabcd(dotFilesDir, true)
	tabline.tab_rename("DotFiles")
end)

-- Name the tab when vim starts up
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.fn.timer_start(200, function()
			M.cwdTab(false, true)
		end)
	end,
	desc = "Rename the tab with the current directory basename",
})

return M
