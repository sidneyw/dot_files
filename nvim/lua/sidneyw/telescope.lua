local actions = require("telescope.actions")
local telescope = require("telescope")
-- local themes = require("telescope.themes")

local symbols = {
	telescope = "",
	github = "",
}

require("telescope").setup({
	defaults = {
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- layout_strategy = "flex",

		mappings = {
			i = {
				["<C-n>"] = false,
				["<C-p>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		current_buffer_fuzzy_find = {
			sorting_strategy = "ascending",
			-- theme = "ivy",
		},
		live_grep = {
			path_display = { "smart" },
			prompt_prefix = symbols.telescope,
		},
		lsp_implementations = {
			theme = "ivy",
			initial_mode = "normal",
		},
		lsp_references = {
			theme = "ivy",
			initial_mode = "normal",
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		-- fzf = {
		--   fuzzy = true,
		--   override_generic_sorter = true,
		--   override_file_sorter = true,
		--   case_mode = "smart_case",
		-- },

		bookmarks = {
			-- Available: 'brave', 'google_chrome', 'safari', 'firefox'
			selected_browser = "brave",

			-- Either provide a shell command to open the URL
			url_open_command = "open",

			-- Or provide the plugin name which is already installed
			-- Available: 'vim_external', 'open_browser'
			url_open_plugin = nil,

			-- Show the full path to the bookmark instead of just the bookmark name
			full_path = true,

			-- Provide a custom profile name for Firefox
			firefox_profile_name = nil,
		},
	},
})

-- Extensions
-- require("telescope").load_extension("git_worktree")
-- telescope.load_extension("fzf")
telescope.load_extension("fzy_native")
telescope.load_extension("gh")
-- telescope.load_extension('coc')
telescope.load_extension("ultisnips")
telescope.load_extension("dap")
telescope.load_extension("notify")
telescope.load_extension("bookmarks")

-- Mappings
vim.cmd([[ nnoremap <C-p>      <cmd>lua require('sidneyw.telescope').project_files()<CR> ]])
vim.cmd([[ nnoremap <leader>f  <cmd>lua require('sidneyw.telescope').project_files()<CR> ]])
vim.cmd([[ nnoremap <leader>a  <cmd>lua require('telescope.builtin').live_grep()<CR> ]])
vim.cmd([[ nnoremap <leader>q  <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR> ]])
vim.cmd([[ nnoremap <leader>b  <cmd>lua require('telescope.builtin').buffers()<CR> ]])
vim.cmd([[ nnoremap <leader>hl <cmd>lua require('telescope.builtin').help_tags()<CR> ]])
vim.cmd([[ nnoremap <leader>m  <cmd>lua require('telescope.builtin').oldfiles()<CR> ]])

vim.cmd([[ cnoreabbr Tele Telescope ]])
vim.cmd([[ cnoreabbr tele Telescope ]])

-- Custom Functions
local M = {}

M.project_files = function(opts)
	opts = opts or {}
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "<Dot Files Search>",
		cwd = "~/.dot_files",
		hidden = true,
	})
end

return M
