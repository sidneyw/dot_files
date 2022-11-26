vim.cmd([[
	autocmd! BufReadPost fugitive://* set bufhidden=delete
	noremap <leader>ga  :Gwrite<CR>
	noremap <leader>gb  :Git blame<CR>
	noremap <leader>gc  :Git commit<CR>
	noremap <leader>gd  :Gvdiff<CR>
	noremap <leader>gh  :!gh-launch<CR>
	noremap <leader>glc :Glcd<CR>
	noremap <leader>gll :Git pull<CR>
	noremap <leader>gr  :Gremove<CR>
	noremap <leader>gs  :Git<CR>
	noremap <leader>gu  :Git push -u<CR>
	"
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
