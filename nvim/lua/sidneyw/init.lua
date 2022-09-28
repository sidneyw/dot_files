require("sidneyw.global") -- experimental
require("sidneyw.telescope")
require("sidneyw.treesitter")
require("sidneyw.nvim-tree")
require("sidneyw.lualine")
require("sidneyw.tab")
require("sidneyw.luasnip-cmp")
require("sidneyw.lsp")
require("sidneyw.null-ls")
require("sidneyw.gitsigns")
require("sidneyw.dap").setup()
require("Comment").setup()
require("nvim-autopairs").setup({})
require("mini.trailspace").setup()
require("rust-tools").setup({})
require("trouble").setup({})
require("todo-comments").setup()

require("symbols-outline").setup({
	highlight_hovered_item = false,
	auto_preview = false,
	width = 40,
	relative_width = false,
	show_numbers = true,
	winblend = 50,
})

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })

vim.api.nvim_set_keymap(
	"n",
	"ge",
	[[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
	{ noremap = true, silent = true }
)

nnoremap("<leader>lb", "<cmd>Make lint-branch<CR>")

-- Reload init.lua
nmap({
	"<leader>sv",
	function()
		R("sidneyw.luasnip-cmp")
	end,
})

vim.notify = require("notify")
