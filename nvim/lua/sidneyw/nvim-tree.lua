-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = false,
	open_on_tab = true,
	hijack_cursor = false,
	update_cwd = true,
	update_to_buf_dir = {
		enable = true,
		auto_open = false,
	},
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
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})

vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_disable_window_picker = 1

vim.cmd([[ nnoremap <C-n> :NvimTreeFindFileToggle<CR> ]])
-- vim.cmd([[ nnoremap <C-n> :NvimTreeFindFile<CR> ]])
