-- TODO: Wrap in autocmd to determine if file is nested underneath the monorepo.
nnoremap("<leader>lb", "<cmd>Make lint-branch<CR>")

nnoremap("<leader>cl", "<cmd>!cpsha<CR>")

vim.cmd([[ cnoreabbr mg Make! gen ]])
vim.cmd([[ cnoreabbr mcl Make! droidcli ]])
