local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local symbols = {
	telescope = "",
	github = "",
	git = "",
	open_folder = "",
	file = "",
}

require("telescope").setup({
	defaults = {
		layout_strategy = "flex",
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-n>"] = false,
				["<C-p>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		git_files = {
			prompt_prefix = symbols.git .. " ",
		},
		current_buffer_fuzzy_find = {
			sorting_strategy = "ascending",
			-- theme = "ivy",
		},
		live_grep = {
			path_display = { "smart" },
			prompt_prefix = symbols.telescope .. " ",
		},
		lsp_implementations = {
			theme = "ivy",
			initial_mode = "normal",
		},
		lsp_references = {
			-- layout_config = {
			-- layout_strategy = "vertical",
			--   vertical = { width = 100, height = 80 },
			-- },
			theme = "ivy",
			initial_mode = "normal",
			fname_width = 55,
			-- show_line = false, -- uncomment to show the text of the reference line
		},
		luasnip = {
			layout_strategy = "vertical",
			layout_config = {
				vertical = { width = 100, height = 80 },
			},
			theme = "dropdown",
			initial_mode = "normal",
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			-- find command (defaults to `fd`)
			find_cmd = "rg",
		},
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
		undo = {
			side_by_side = true,
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.8,
			},
		},
	},
})

-- Extensions
telescope.load_extension("fzy_native")
telescope.load_extension("gh")
telescope.load_extension("luasnip")
telescope.load_extension("dap")
telescope.load_extension("notify")
telescope.load_extension("bookmarks")
telescope.load_extension("goimpl")
telescope.load_extension("media_files")
telescope.load_extension("undo")

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

require("which-key").register({
	["<leader>f"] = { M.project_files, "Project files" },
	["<C-p>"] = { builtin.find_files, "Find files" },
	["<leader>a"] = { builtin.live_grep, "Live grep" },
	["<leader>q"] = { builtin.current_buffer_fuzzy_find, "Fuzzy find" },
	["<leader>s"] = { builtin.lsp_document_symbols, "LSP document symbols" },
	["<leader>b"] = { builtin.buffers, "Buffers" },
	["<leader>hl"] = { builtin.help_tags, "Help tags" },
	["<leader>m"] = { builtin.oldfiles, "Old files" },
	["<leader>tr"] = { builtin.resume, "Resume" },
})
-- nnoremap("<leader>s", builtin.lsp_workspace_symbols)

vim.api.nvim_set_keymap(
	"n",
	"ge",
	[[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
	{ noremap = true, silent = true }
)

local utils = {
	{ name = "Commits", fn = builtin.git_commits, desc = "Show commits" },
	{ name = "Bcommits", fn = builtin.git_bcommits, desc = "Show buffer commits" },
	{ name = "Branches", fn = builtin.git_branches, desc = "Show branches" },
	{ name = "Marks", fn = builtin.marks, desc = "Show marks" },
	{ name = "Keymaps", fn = builtin.keymaps, desc = "Show keymaps" },
	{ name = "Colors", fn = builtin.colorscheme, desc = "Show colorschemes" },
}

for _, command in pairs(utils) do
	vim.api.nvim_create_user_command(command.name, command.fn, {
		nargs = 0,
		desc = command.desc,
	})
end

return M