vim.cmd([[
	augroup vimrc-remember-cursor-position
		autocmd!
		autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
	augroup END

	augroup gitcommit
		autocmd!
		autocmd FileType gitcommit :setlocal wrap spell textwidth=72
	augroup END

	augroup yaml
		autocmd!
		autocmd BufNewFile,BufRead *.yml,*.yaml setlocal filetype=helm
		autocmd FileType yaml,helm :call ShortTab()
	augroup END

	" augroup helm
	"   autocmd!
	"   autocmd FileType helm :setlocal commentstring=#\ %s
	" augroup END
	"

	augroup starlark
		autocmd!
		autocmd BufNewFile,BufReadPost *.star set filetype=python
	augroup END

	augroup proto
		autocmd!
		autocmd FileType proto :call LongTab()
	augroup END

	augroup telescope
		autocmd!
		" Turn off auto complete for Telescope prompts
		autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { completion = { autocomplete = false } }
	augroup END
]])
