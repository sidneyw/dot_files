-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require("nvim-tree").setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true, -- default setting is false
  update_cwd = false,
	disable_netrw = false,
	open_on_tab = false,
	hijack_directories = {
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
	view = {
		width = 40,
	},
	renderer = { symlink_destination = false },
})

vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_git_hl = 1
-- vim.g.nvim_tree_respect_buf_cwd = 1
-- vim.g.nvim_tree_disable_window_picker = 1

vim.cmd([[ nnoremap <C-n> :NvimTreeFindFileToggle<CR> ]])
-- vim.cmd([[ nnoremap <C-n> :NvimTreeFindFile<CR> ]])
