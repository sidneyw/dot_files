local opt = vim.opt

vim.g.mapleader = "-"
vim.g.maplocalleader = "\\"

opt.relativenumber = true
opt.number = true
opt.updatetime = 500

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query

opt.shortmess = "filnxtToOFc"

opt.termguicolors = true
opt.colorcolumn = "+1"
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = true
opt.inccommand = "split"
opt.belloff = "all" -- Just turn the dang bell off

opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true
opt.formatoptions = opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore
opt.joinspaces = false

opt.clipboard = "unnamedplus"

opt.scrolloff = 3 -- always 3 lines above/below the cursor
