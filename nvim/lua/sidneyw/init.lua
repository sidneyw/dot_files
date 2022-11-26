require("sidneyw.global") -- experimental

if require("sidneyw.first-load")() then
	return
end

require("config.opts")
require("sidneyw.plugins")

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
require("sidneyw.symbolsoutline")
require("sidneyw.chronosphere")

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })

vim.api.nvim_set_keymap(
	"n",
	"ge",
	[[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
	{ noremap = true, silent = true }
)

-- Reload init.lua
nmap({
	"<leader>sv",
	function()
		R("sidneyw.luasnip-cmp")
	end,
})

vim.notify = require("notify")
