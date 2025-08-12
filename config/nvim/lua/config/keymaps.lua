-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

-- switch ; and :
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ":", ";", { noremap = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("v", ":", ";", { noremap = true })

-- Remove line movement mappings from lazyvim
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")
vim.keymap.del("n", "<leader>qq")

wk.add({
  { "<S-Tab>", ":tabprevious<CR>", desc = "Previous Tab" },
  { "<Tab>", ":tabnext<CR>", desc = "Next Tab" },
  { "<leader>v", ":<C-u>vsplit<CR>", desc = "Split vertically" },
  { "<leader>fc", function() require("utils.telescope-functions").open_git_file_from_clipboard() end, desc = "Open git file from clipboard" },
})

vim.cmd([[
  nnoremap <leader>tc :tabc<CR>

  nnoremap <space> zt

  " Move lines up/down
  nnoremap n nzzzv
  nnoremap N Nzzzv

  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  vnoremap <leader>s :sort<cr>

  nnoremap <C-^> :b# <CR>
  nnoremap <C-n>i <C-i>
]])
