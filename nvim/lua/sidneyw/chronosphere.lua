-- TODO: Wrap in autocmd to determine if file is nested underneath the monorepo.
nnoremap("<leader>lb", "<cmd>Make lint-branch<CR>")

vim.cmd([[ cnoreabbr mg Make! gen ]])
