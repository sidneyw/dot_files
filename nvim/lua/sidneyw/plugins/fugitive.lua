-- Mappings
nnoremap("<leader>ga", "<cmd>Gwrite<CR>")
nnoremap("<leader>gb", "<cmd>Git blame<CR>")
nnoremap("<leader>gc", "<cmd>Git commit<CR>")
nnoremap("<leader>gd", "<cmd>Gvdiff<CR>")
nnoremap("<leader>glc", "<cmd>Glcd<CR>")
nnoremap("<leader>gll", "<cmd>Git pull<CR>")
nnoremap("<leader>gr", "<cmd>Gremove<CR>")
nnoremap("<leader>gs", "<cmd>Git<CR>")
nnoremap("<leader>gu", "<cmd>Git push -u<CR>")

-- -- Copy github link to line or highlighted lines to clipboard
-- nnoremap("<leader>go", "<cmd>.GBrowse!<CR>")
-- vnoremap("<leader>go", "<cmd>'<,'>GBrowse!<CR>")
--
-- -- Open github in browser to line or highlighted lines to clipboard
-- nnoremap("<leader>gn", "<cmd>.GBrowse<CR>")
-- vnoremap("<leader>gn", "<cmd>'<,'>GBrowse<CR>")

vim.cmd([[
	augroup gitcommit
		autocmd!
		autocmd FileType gitcommit :setlocal textwidth=72
		autocmd BufReadPost fugitive://* set bufhidden=delete
		autocmd Filetype fugitive syntax on
	augroup END

  " Open current line on github
  nnoremap <leader>gn :.GBrowse<CR>
  vnoremap <leader>gn :'<,'>GBrowse<CR>

  " Copy the github link to the clipboard
  nnoremap <leader>go :.GBrowse!<CR>
  vnoremap <leader>go :'<,'>GBrowse!<CR>

	cnoreabbr Gco Git co
	cnoreabbr Gpush Git push
	cnoreabbr Gcommit Git commit
	cnoreabbr Gcb Git co -b
	cnoreabbr Gstash Git stash
]])
