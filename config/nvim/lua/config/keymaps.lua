-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

-- switch ; and :
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ":", ";", { noremap = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("v", ":", ";", { noremap = true })

wk.register({
  ["<S-Tab>"] = { ":tabprevious<CR>", "Previous Tab" },
  ["<Tab>"] = { ":tabnext<CR>", "Next Tab" },
  ["<leader>cs"] = { ":!cpsha<CR>", "Copy 12-char SHA" },
  ["<leader>lb"] = { ":Make! lint-branch<CR>", "Lint Branch" },
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

vim.cmd([[
  cnoreabbr mg Make! gen
  cnoreabbr mcl Make! droidcli
]])
