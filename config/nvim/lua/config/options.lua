-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- change the leader key to -
vim.g.mapleader = "-"

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.updatetime = 500

-- opt.tabstop = 2
-- opt.shiftwidth = 2
-- opt.softtabstop = 2
-- opt.expandtab = true
opt.textwidth = 100

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query

opt.foldlevelstart = 15 -- most folds should be open on start
opt.shortmess:append("c")

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
opt.conceallevel = 0
opt.swapfile = false -- turn off swap files

-- vim.g.make = "make"
vim.cmd([[
  let g:make = 'gmake'
  if exists('make')
    let g:make = 'make'
  endi
]])
