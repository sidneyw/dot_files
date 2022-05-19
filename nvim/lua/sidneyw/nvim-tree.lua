-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = true,
	open_on_setup = false,
	open_on_tab = false,
	hijack_directories = {
		enable = true,
		auto_open = false,
	},
	ignore_ft_on_setup = {},
	hijack_cursor = false,
	update_cwd = false,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 40,
	},
})

vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_git_hl = 1
-- vim.g.nvim_tree_disable_window_picker = 1

vim.cmd([[ nnoremap <C-n> :NvimTreeFindFileToggle<CR> ]])
-- vim.cmd([[ nnoremap <C-n> :NvimTreeFindFile<CR> ]])
