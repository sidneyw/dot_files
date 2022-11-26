local tabline = require("tabline")
local notify = require("notify")

local telescopeCustom = require("sidneyw.plugins.telescope")

local dotFilesDir = vim.fn.expand("~/.dot_files/")
local chronoDir = vim.fn.expand("~/go/src/github.com/chronosphereio/")

local M = {}

function M.Rename(location, show_buffers, skipRename)
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

function M.New(directory, skipRename)
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

	M.Rename(directory, false, skipRename)
	telescopeCustom.project_files()
end

function M.NewChrono(subdir)
	local location = chronoDir .. subdir
	M.New(location)
end

nmap({ "]b", tabline.buffer_next })
nmap({ "[b", tabline.buffer_previous })

local function jumpPrefix(key)
	return "<leader>e" .. key
end

nnoremap(jumpPrefix("m"), function()
	M.NewChrono("monorepo")
end)

nnoremap(jumpPrefix("e"), function()
	M.NewChrono("envconfig")
end)

nnoremap(jumpPrefix("c"), function()
	M.NewChrono("collector")
end)

nnoremap(jumpPrefix("v"), function()
	M.New(dotFilesDir, true)
	tabline.tab_rename("DotFiles")
end)

-- Name the tab when vim starts up
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.fn.timer_start(200, function()
			M.Rename(false, true)
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

vim.cmd([[
	cnoreabbr tabcd TabCD
	cnoreabbr tcd TabCD
	cnoreabbr trn TablineTabRename
]])

return M
